#!/bin/bash

HTTP_PORT="${HTTP_PORT:-18545}"
WS_PORT="${WS_PORT:-18546}"
ADDRESS="${ADDRESS:-127.0.0.1}"
PORT="${PORT:-30311}"
SYNCMODE="${SYNCMODE:-snap}"
EXTRAFLAGS="${EXTRAFLAGS:-""}"

exec geth_linux \
    --ipcdisable \
    --syncmode ${SYNCMODE} \
    --nat none \
    --rpc.allow-unprotected-txs \
    --txlookuplimit 0 \
    --cache 4096 \
    --port ${PORT} \
    --http \
    --http.addr ${ADDRESS} \
    --http.port=${HTTP_PORT} \
    --http.vhosts '*' \
    --http.corsdomain '*' \
    --ws \
    --ws.addr ${ADDRESS} \
    --ws.port ${WS_PORT} \
    --ws.origins '*' \
    --config ./config.toml \
    ${EXTRAFLAGS}