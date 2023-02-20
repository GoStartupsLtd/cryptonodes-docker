#!/bin/bash

RPC_USER="${RPC_USER:-user}"
RPC_PASS="${RPC_PASS:-pass}"
RPC_PORT="${RPC_PORT:-8333}"
RPC_ALLOW_IP="${RPC_ALLOW_IP:-127.0.0.1}"
TESTNET="${TESTNET:-0}"
EXTRAFLAGS="${EXTRAFLAGS:-""}"
DEBIAN_FRONTEND="${DEBIAN_FRONTEND:-noninteractive}"
RPC_BIND="${RPC_BIND:-0.0.0.0}"

bgoldd -port=$RPC_PORT \
    -rpcallowip=$RPC_ALLOW_IP \
    -rpcbind=$RPC_BIND \
    -listen \
    -server \
    -testnet=$TESTNET \
    $EXTRAFLAGS
