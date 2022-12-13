FROM golang

ENV HEIMDALL_GENESIS_URL=https://raw.githubusercontent.com/maticnetwork/launch/master/mainnet-v1/sentry/sentry/heimdall/config/genesis.json
ENV HEIMDALL_CHAIN_ID=heimdall-137
ENV HEIMDALL_SEEDS="f4f605d60b8ffaaf15240564e58a81103510631c@159.203.9.164:26656,4fb1bc820088764a564d4f66bba1963d47d82329@44.232.55.71:26656,2eadba4be3ce47ac8db0a3538cb923b57b41c927@35.199.4.13:26656,3b23b20017a6f348d329c102ddc0088f0a10a444@35.221.13.28:26656,25f5f65a09c56e9f1d2d90618aa70cd358aa68da@35.230.116.151:26656"
ENV HEIMDALL_BOR_RPC_URL=http://bor0:8545
ENV HEIMDALL_ETH_RPC_URL=http://localhost:8546
ENV HEIMDALL_BRIDGE=tcp://0.0.0.0:26657
ENV HEIMDALL_OPEN_CONNECTIONS=0
ENV HEIMDALL_HOME=/root/.heimdalld
# 0 max open connections means infinite.
ENV HEIMDALL_MAX_OPEN_CONNECTIONS=0
ENV HEIMDALL_MAX_INBOUND_PEERS=300
ENV HEIMDALL_MAX_OUTBOUND_PEERS=300

ENV BOR_SETUP https://raw.githubusercontent.com/maticnetwork/launch/master/mainnet-v1/sentry/sentry/bor/setup.sh
ENV BOR_START https://raw.githubusercontent.com/maticnetwork/launch/master/mainnet-v1/sentry/sentry/bor/start.sh
ENV BOR_GENESIS https://raw.githubusercontent.com/maticnetwork/launch/master/mainnet-v1/sentry/sentry/bor/genesis.json
ENV BOR_STATIC_FILE https://raw.githubusercontent.com/maticnetwork/launch/master/mainnet-v1/sentry/sentry/bor/static-nodes.json
ENV BOR_MODE "full"
ENV BOR_BOOTNODES "enode://0cb82b395094ee4a2915e9714894627de9ed8498fb881cec6db7c65e8b9a5bd7f2f25cc84e71e89d0947e51c76e85d0847de848c7782b13c0255247a6758178c@44.232.55.71:30303,enode://88116f4295f5a31538ae409e4d44ad40d22e44ee9342869e7d68bdec55b0f83c1530355ce8b41fbec0928a7d75a5745d528450d30aec92066ab6ba1ee351d710@159.203.9.164:30303"

ENV HTTP_PORT=8542
ENV WS_PORT=8545
ENV ADDRESS=127.0.0.1
ENV PORT=30301
ENV SYNCMODE=full
ENV EXTRAFLAGS=""

WORKDIR /root/

# Bor/heimdall peer network port
EXPOSE 30303
EXPOSE 30301
# RPC server
EXPOSE 8545
#WS server
EXPOSE 8546
EXPOSE 26656
EXPOSE 26657
EXPOSE 1317

RUN apt-get install -y git

RUN git clone https://github.com/maticnetwork/bor/
RUN git clone https://github.com/maticnetwork/heimdall 

RUN cd bor \
    && make bor

RUN cd heimdall \
    && git checkout mainnet-alchemy \
    && make install

RUN mkdir -p /root/logs \
    && touch /root/logs/heimdalld.log \
    && touch /root/logs/rest-server.log \
    && touch /root/logs/bridge.log \
    && touch /root/logs/bor.log

#setup heimdall config and home directory
RUN heimdalld init --home ${HEIMDALL_HOME} --chain-id ${HEIMDALL_CHAIN_ID}

# download heimdall genesis file
RUN wget -q -O ${HEIMDALL_HOME}/config/genesis.json ${HEIMDALL_GENESIS_URL} -P ${HEIMDALL_HOME}/config


ADD polygon.sh .

RUN chmod +x ./polygon.sh

RUN sed -i "/seeds =/c\seeds = \"${HEIMDALL_SEEDS}\"" ${HEIMDALL_HOME}/config/config.toml \
    && sed -i "/26657/c\laddr = \"${HEIMDALL_BRIDGE}\"" ${HEIMDALL_HOME}/config/config.toml \
    && sed -i "/bor_rpc_url/c\bor_rpc_url = \"${HEIMDALL_BOR_RPC_URL}\"" ${HEIMDALL_HOME}/config/config.toml \
    && sed -i "/eth_rpc_url/c\eth_rpc_url = \"${HEIMDALL_ETH_RPC_URL}\"" ${HEIMDALL_HOME}/config/config.toml \
    && sed -i "/^max_open_connections =/c\max_open_connections = \"${HEIMDALL_MAX_OPEN_CONNECTIONS}\"" ${HEIMDALL_HOME}/config/config.toml \
    && sed -i "/max_num_inbound_peers =/c\max_num_inbound_peers = \"${HEIMDALL_MAX_INBOUND_PEERS}\"" ${HEIMDALL_HOME}/config/config.toml \
    && sed -i "/max_num_outbound_peers =/c\max_num_outbound_peers = \"${HEIMDALL_MAX_OUTBOUND_PEERS}\"" ${HEIMDALL_HOME}/config/config.toml

CMD ./polygon.sh