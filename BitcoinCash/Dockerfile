FROM debian:9

ENV RPC_USER=user
ENV RPC_PASS=pass
ENV RPC_PORT=8332
ENV RPC_ALLOW_IP=127.0.0.1
ENV ZMQ_PORT=29000
ENV ZMQ_ADDRESS=localhost
ENV TESTNET=0
ENV EXTRAFLAGS=""

RUN apt-get update && apt-get upgrade && apt-get install -y wget
RUN wget https://github.com/bitcoin-cash-node/bitcoin-cash-node/releases/download/v24.0.0/bitcoin-cash-node-24.0.0-x86_64-linux-gnu.tar.gz
RUN tar xzf bitcoin-cash-node-24.0.0-x86_64-linux-gnu.tar.gz
RUN install -m 0755 -o root -g root -t /usr/local/bin bitcoin-cash-node-24.0.0/bin/*

EXPOSE ${RPC_PORT}
EXPOSE ${ZMQ_PORT}

ENTRYPOINT bitcoind -rpcuser="$RPC_USER" \
    -rpcpassword="$RPC_PASS" \
    -rpcport="$RPC_PORT" \
    -rpcallowip="${RPC_ALLOW_IP}" \
    -rpcbind=0.0.0.0 \
    -listen \
    -server \
    -testnet=${TESTNET} \
    ${EXTRAFLAGS}