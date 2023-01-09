FROM golang

WORKDIR /root/

ENV LOGS_FOLDER /root/logs

ENV HEIMDALL_GENESIS_URL=https://raw.githubusercontent.com/maticnetwork/launch/master/mainnet-v1/sentry/sentry/heimdall/config/genesis.json
ENV HEIMDALL_CHAIN_ID=heimdall-137

RUN apt-get install -y git

RUN git clone https://github.com/maticnetwork/bor/ \
    && cd bor && make bor
RUN git clone https://github.com/maticnetwork/heimdall/ \
    && cd heimdall && git checkout mainnet-alchemy && make install


RUN heimdalld init --home /root/.heimdalld --chain-id ${HEIMDALL_CHAIN_ID}  
# setup config files
RUN wget -q -O /root/.heimdalld/config/genesis.json ${HEIMDALL_GENESIS_URL} -P /root/.heimdalld/config

COPY run.sh run.sh

EXPOSE 30303
EXPOSE 8545
EXPOSE 8546
EXPOSE 26656

CMD ./run.sh