#!/bin/bash

HTTP_PORT="${HTTP_PORT:-8545}"
WS_PORT="${WS_PORT:-8546}"
PORT="${PORT:-30303}"
SYNCMODE="${SYNCMODE:-snap}"
EXTRAFLAGS="${EXTRAFLAGS}"

./prysm.sh beacon-chain \
    --execution-endpoint=/root/.ethereum/geth.ipc \
    --accept-terms-of-use &

exec geth --syncmode ${SYNCMODE} \
    --nat none \
    --txlookuplimit 0 \
    --cache 4096
    --port ${PORT} \
    --http \
    --http.addr 0.0.0.0 \
    --http.port=${HTTP_PORT} \
    --http.vhosts '*' \
    --http.corsdomain '*' \
    --ws \
    --ws.addr ${ADDRESS} \
    --ws.port ${WS_PORT} \
    --ws.origins '*' \
    ${EXTRAFLAGS}
