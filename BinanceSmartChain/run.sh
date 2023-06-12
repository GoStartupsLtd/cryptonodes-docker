#!/bin/bash

awk '/\[Node.LogConfig\]/ {exit} {sub(/MaxPeers = 30/, "MaxPeers = 100");print}' /home/config.toml > /home/temp.toml && mv /home/temp.toml /home/config.toml

HTTP_PORT="${HTTP_PORT:-18545}"
WS_PORT="${WS_PORT:-18546}"
ADDRESS="${ADDRESS:-0.0.0.0}"
PORT="${PORT:-30311}"
SYNCMODE="${SYNCMODE:-snap}"
EXTRAFLAGS="${EXTRAFLAGS:-""}"

exec geth --syncmode ${SYNCMODE} \
    --nat none \
    --txlookuplimit 0 \
    --cache 4096 \
    --port ${PORT} \
    --http \
    --http.addr ${ADDRESS} \
    --ipcdisable \
    --rpc.allow-unprotected-txs \
    --http.port=${HTTP_PORT} \
    --http.vhosts '*' \
    --http.corsdomain '*' \
    --ws \
    --ws.addr ${ADDRESS} \
    --ws.port ${WS_PORT} \
    --ws.origins '*' \
    --config ./config.toml \
    ${EXTRAFLAGS}
