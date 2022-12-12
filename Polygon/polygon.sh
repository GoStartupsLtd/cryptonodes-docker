#!/bin/bash
mkdir /root/logs \
    && touch /root/logs/heimdalld.log \
    && touch /root/logs/rest-server.log \
    && touch /root/logs/bridge.log \
    && touch /root/logs/bor.log
# heimdall configuration
sed -i "/seeds =/c\seeds = \"${HEIMDALL_SEEDS}\"" ${HEIMDALL_HOME}/config/config.toml \
    && sed -i "/26657/c\laddr = \"${HEIMDALL_BRIDGE}\"" ${HEIMDALL_HOME}/config/config.toml \
    && sed -i "/bor_rpc_url/c\bor_rpc_url = \"${HEIMDALL_BOR_RPC_URL}\"" ${HEIMDALL_HOME}/config/config.toml \
    && sed -i "/eth_rpc_url/c\eth_rpc_url = \"${HEIMDALL_ETH_RPC_URL}\"" ${HEIMDALL_HOME}/config/config.toml
#start heimdall, heimdall rest server with logs.
echo $HTTP_PORT
echo $ADDRESS
WS_PORT=2222
echo $WS_PORT

heimdalld start 2>&1 | tee /root/logs/heimdalld.log &
    heimdalld rest-server 2>&1 | tee /root/logs/rest-server.log &
    bridge start 2>&1 | tee /root/logs/bridge.log &
    #start bor server
    bor server -ipcdisable \
    -syncmode ${SYNCMODE} \
    -nat none \
    -txlookuplimit 0 \
    -cache 16000 \
    -port ${PORT} \
    -http \
    -http.addr ${ADDRESS} \
    -http.port=${HTTP_PORT} \
    -http.vhosts '*' \
    -http.corsdomain '*' \
    -ws \
    -ws.addr ${ADDRESS} \
    -ws.port ${WS_PORT} \
    -ws.origins '*' \
    ${EXTRAFLAGS} 2>&1 | tee /root/logs/bor.log