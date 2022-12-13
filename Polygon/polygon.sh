#!/bin/bash
mkdir -p /root/logs \
    && touch /root/logs/heimdalld.log \
    && touch /root/logs/rest-server.log \
    && touch /root/logs/bridge.log \
    && touch /root/logs/bor.log
#start heimdall, heimdall rest server with logs.
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