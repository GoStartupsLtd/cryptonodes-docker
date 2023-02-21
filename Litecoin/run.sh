#!/bin/bash

RPC_USER="${RPC_USER:-}"
RPC_PASS="${RPC_PASS:-}"
RPC_PORT="${RPC_PORT:-22556}"
RPC_ALLOW_IP="${RPC_ALLOW_IP:-127.0.0.1}"
RPC_BIND="${RPC_BIND:-0.0.0.0}"
TESTNET="${RPC_TESTNET:-0}"
EXTRAFLAGS="${EXTRAFLAGS:-}"
DEBIAN_FRONTEND="${DEBIAN_FRONTEND:-noninteractive}"

exec litecoind -port=$RPC_PORT \
    -rpcpassword=$RPC_PASS \
    -rpcport=$RPC_PORT \
    -rpcallowip=$RPC_ALLOW_IP \
    -rpcbind=$RPC_BIND \
    -listen \
    -server \
    -testnet=$TESTNET \
    $EXTRAFLAGS