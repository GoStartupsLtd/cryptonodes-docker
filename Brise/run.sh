#!/bin/bash
RPC_HOST="${RPC_HOST:-localhost}"
RPC_PORT="${RPC_PORT:-8545}"
WS_PORT="${WS_PORT:-8036}"
ADDRESS="${ADDRESS:-0.0.0.0}"
PORT="${PORT:-30303}"

DATA_DIR="${DATA_DIR:-/root/.ethereum}"

SYNCMODE="${full}"
EXTRAFLAGS="${EXTRAFLAGS:-}"
BOOTNODES="${BOOTNODES:-}"

geth --datadir ${DATA_DIR} init /root/brise_mainnet.json

exec geth --datadir ${DATA_DIR}  --port $PORT --http --http.addr $ADDRESS --http.port=$RPC_PORT --http.vhosts \'*\' --http.corsdomain \'*\' \
--ws --ws.addr $ADDRESS --ws.port $WS_PORT --ws.origins \'*\' --bootnodes $BOOTNODES --networkid 32520 ${EXTRAFLAGS}