#!/bin/bash

# If no RPC password is set the node will use a randomly generated password located at ~/root/.bitcoin/.cookie

RPC_USER="${RPC_USER:-user}"
RPC_PASS="${RPC_PASS:-pass}"
RPC_PORT="${RPC_PORT:-8336}"
RPC_ALLOW_IP="${RPC_ALLOW_IP:-0.0.0.0/0}"
TESTNET="${TESTNET:-0}"
EXTRAFLAGS="${EXTRAFLAGS:-""}"
DEBIAN_FRONTEND="${DEBIAN_FRONTEND:-noninteractive}"
RPC_BIND="${RPC_BIND:-0.0.0.0}"
EXTRAFLAGS="${EXTRAFLAGS:-}"

exec bgoldd -rest -server \
    -rpcbind=$RPC_BIND \
    -rpcallowip=$RPC_ALLOW_IP \
    -rpcport=$RPC_PORT \
    -rpcuser=$RPC_USER \
    -rpcpassword=$RPC_PASS \
    -testnet=$TESTNET \
    $EXTRAFLAGS