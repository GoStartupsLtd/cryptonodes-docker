#!/bin/bash

RPC_USER="${RPC_USER:-user}"
RPC_PASS="${RPC_PASS:-pass}"
RPC_PORT="${RPC_PORT:-8332}"
RPC_ALLOW_IP="${RPC_ALLOW_IP:-127.0.0.1}"
ZMQ_PORT="${ZMQ_PORT:-29000}"
ZMQ_ADDRESS="${ZMQ_ADDRESS:-localhost}"
TESTNET="${TESTNET:-0}"
EXTRAFLAGS="${EXTRAFLAGS:-""}"
DEBIAN_FRONTEND="${DEBIAN_FRONTEND:-noninteractive}"
RPC_BIND="${RPC_BIND:-0.0.0.0}"

exec bitcoind -rpcuser="$RPC_USER" \
    -rpcpassword="$RPC_PASS" \
    -port="$RPC_PORT" \
    -rpcallowip="$RPC_ALLOW_IP" \
    -rpcbind="$RPC_BIND" \
    -listen \
    -server \
    -zmqpubhashblock="tcp://$ZMQ_ADDRESS:$ZMQ_PORT" \
    -zmqpubhashtx="tcp://$ZMQ_ADDRESS:$ZMQ_PORT" \
    -zmqpubrawblock="tcp://$ZMQ_ADDRESS:$ZMQ_PORT" \
    -zmqpubrawtx="tcp://$ZMQ_ADDRESS:$ZMQ_PORT" \
    -zmqpubsequence="tcp://$ZMQ_ADDRESS:$ZMQ_PORT" \
    -testnet=$TESTNET \
    $EXTRAFLAGS