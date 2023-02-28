#!/bin/bash

HTTP_PORT="${HTTP_PORT:-8547}"
WS_PORT="${WS_PORT:-8548}"
PORT="${PORT:-30303}"
SYNCMODE="${SYNCMODE:-snap}"
ADDRESS="${ADDRESS:-127.0.0.1}"
EXTRAFLAGS="${EXTRAFLAGS}"

exec geth --syncmode ${SYNCMODE} \
    --nat none \
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
    ${EXTRAFLAGS}
