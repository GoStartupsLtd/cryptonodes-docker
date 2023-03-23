#!/bin/bash

ADDRESS="${ADDRESS:-0.0.0.0}"
EVM_RPC_PORT="${EVM_RPC_PORT:-8549}"
TENDERMINT_RPC_PORT="${TENDERMINT_RPC_PORT:-8550}"
WS_PORT="${WS_PORT:-8551}"
EXCHAIND_HOME="${EXCHAIND_HOME:-/home/exchaind}"
CHAIN_ID="${CHAIN_ID:-exchain-66}"
EXTRAFLAGS="${EXTRAFLAGS:-}"

START_FROM_SNAPSHOT="${START_FROM_SNAPSHOT:-true}"

if [ "${START_FROM_SNAPSHOT}" = "true" ]; then
    mkdir -p ${EXCHAIND_HOME}
    wget -q -O - https://okg-pub-hk.oss-cn-hongkong.aliyuncs.com/cdn/okc/snapshot/mainnet-s1-20230306-17837049-rocksdb.tar.gz | tar -zxv -C ${EXCHAIND_HOME}
else
    curl --create-dirs https://raw.githubusercontent.com/okx/mainnet/main/genesis.json -o ${EXCHAIND_HOME}/config/genesis.json
fi

exec exchaind start \
    --home ${EXCHAIND_HOME} \
    --rpc.laddr tcp://${ADDRESS}:${TENDERMINT_RPC_PORT} \
    --rest.laddr tcp://${ADDRESS}:${EVM_RPC_PORT} \
    --wsport=${WS_PORT} \
    --iavl-enable-async-commit=false \
    --fast-query=false \
    ${EXTRAFLAGS}
