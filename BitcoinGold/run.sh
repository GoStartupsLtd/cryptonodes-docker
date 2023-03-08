#!/bin/bash

RPC_USER="${RPC_USER:-user}"
RPC_PASS="${RPC_PASS:-pass}"

RPC_PORT="${RPC_PORT:-8336}"
RPC_ALLOW_IP="${RPC_ALLOW_IP:-0.0.0.0/0}"
TESTNET="${TESTNET:-0}"
EXTRAFLAGS="${EXTRAFLAGS:-""}"
DEBIAN_FRONTEND="${DEBIAN_FRONTEND:-noninteractive}"
RPC_BIND="${RPC_BIND:-0.0.0.0}"
DATA_DIR="${DATA_DIR:-/home/bgoldd}"

mkdir -p ${DATA_DIR} &&
    exec bgoldd -rpcport=$RPC_PORT \
    -datadir=$DATA_DIR \
    -rpcallowip=$RPC_ALLOW_IP \
    -rpcbind=$RPC_BIND \
    -rpcuser=$RPC_USER \
    -rpcpassword=$RPC_PASS \
    -rest \
    -listen \
    -server \
    -testnet=$TESTNET \
    $EXTRAFLAGS
