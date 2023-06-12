#!/bin/bash

HTTP_PORT="${HTTP_PORT:-8547}"
WS_PORT="${WS_PORT:-8548}"
PORT="${PORT:-30303}"
SYNCMODE="${SYNCMODE:-snap}"
ADDRESS="${ADDRESS:-0.0.0.0}"
EXTRAFLAGS="${EXTRAFLAGS}"

exec geth --syncmode ${SYNCMODE} \
    --nat none \
    --ipcdisable \
    --txlookuplimit 0 \
    --cache 4096 \
    --port ${PORT} \
    --http \
    --http.addr ${ADDRESS} \
    --http.port ${HTTP_PORT} \
    --http.vhosts "*" \
    --http.corsdomain "*" \
    --http.api "eth,net,web3,debug,txpool" \
    --ws \
    --ws.addr ${ADDRESS} \
    --ws.port ${WS_PORT} \
    --ws.origins "*" \
    --ws.api "eth,net,web3,debug,txpool" \
    ${EXTRAFLAGS}

 