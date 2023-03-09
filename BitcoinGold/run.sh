#!/bin/bash

RPC_USER="${RPC_USER:-user}"
RPC_PASS="${RPC_PASS:-pass}"
RPC_PORT="${RPC_PORT:-8336}"
RPC_ALLOW_IP="${RPC_ALLOW_IP:-0.0.0.0/0}"
RPC_BIND="${RPC_BIND:-0.0.0.0}"

TESTNET="${TESTNET:-0}"
DEBIAN_FRONTEND="${DEBIAN_FRONTEND:-noninteractive}"
EXTRAFLAGS="${EXTRAFLAGS:-""}"

mkdir -p ${DATA_DIR} && 
    exec bgoldd -rpcport=$RPC_PORT \
    -rpcallowip=$RPC_ALLOW_IP \
    -rpcbind=$RPC_BIND \
    -rpcuser=$RPC_USER \
    -rpcpassword=$RPC_PASS \
    -rest \
    -server \
    -testnet=$TESTNET \
    $EXTRAFLAGS
