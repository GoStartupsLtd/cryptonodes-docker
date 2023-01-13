#!/bin/bash
RPC_HOST="${RPC_HOST:-localhost}"
RPC_PORT="${RPC_PORT:-8545}"
WS_PORT="${WS_PORT:-8036}"
ADDRESS="${ADDRESS:-0.0.0.0}"
PORT="${PORT:-30303}"

DATA_DIR="${DATA_DIR:-/root/.ethereum}"

SYNCMODE="${full}"
EXTRAFLAGS="${EXTRAFLAGS:-}"
BOOTNODES="${BOOTNODES:-enode://5b0a02ce4e3c3f182d1c9aaf06c02d2541f99c9f004406cab3ee8079eaed4afbca08f0acdd615a17e793d3ebfdd428ba6a644ab48e1a2f3e15c17265d5964fe7@141.95.124.34:40605,enode://4269e56c73d4ecac60c6087d2bfe567121f6aa04d2c742e6992bce1ad7040db3d935cc1bf3758d90247a53252eec3fe4a402282af70c06a3d32d13b92aefcb5f@141.95.124.35:40605,enode://c720ce64279be5fbc68e10991fa9d47beb7131a8b57468d44c38154e243b6a669f5016db00f7640ba94698db586f056d16bb1f3c71e0d220b9a1858307b58dd8@146.59.54.152:40605,enode://1b73b153b934ec9ef5eb566b571787b129950e920d85c5696a07f4016d447b107e439030596805b437f4319d9d8ac43264ea05897a6b0b7e6161fba177dbd2fc@146.59.84.163:40605}"

geth --datadir ${DATA_DIR} init /root/brise_mainnet.json

exec geth --datadir ${DATA_DIR}  --port $PORT --http --http.addr $ADDRESS --http.port=$RPC_PORT --http.vhosts \'*\' --http.corsdomain \'*\' \
--ws --ws.addr $ADDRESS --ws.port $WS_PORT --ws.origins \'*\' --bootnodes $BOOTNODES --networkid=32520 ${EXTRAFLAGS}