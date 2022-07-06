FROM debian:9

ENV RPC_USER=user
ENV RPC_PASS=pass
ENV RPC_PORT=8332
ENV RPC_ALLOW_IP=127.0.0.1
ENV ZMQ_PORT=29000
ENV ZMQ_ADDRESS=localhost
ENV TESTNET=0
ENV EXTRAFLAGS=""
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade && apt-get install -y wget
RUN wget https://bitcoin.org/bin/bitcoin-core-0.21.0/bitcoin-0.21.0-x86_64-linux-gnu.tar.gz
RUN tar xzf bitcoin-0.21.0-x86_64-linux-gnu.tar.gz
RUN install -m 0755 -o root -g root -t /usr/local/bin bitcoin-0.21.0/bin/*

EXPOSE ${RPC_PORT}
EXPOSE ${ZMQ_PORT}

ENTRYPOINT bitcoind -rpcuser="$RPC_USER" \
    -rpcpassword="$RPC_PASS" \
    -rpcport="$RPC_PORT" \
    -rpcallowip="${RPC_ALLOW_IP}" \
    -rpcbind=0.0.0.0 \
    -listen \
    -server \
    -zmqpubhashblock="tcp://${ZMQADDRESS}:${ZMQ_PORT}" \
    -zmqpubhashtx="tcp://${ZMQADDRESS}:${ZMQ_PORT}" \
    -zmqpubrawblock="tcp://${ZMQADDRESS}:${ZMQ_PORT}" \
    -zmqpubrawtx="tcp://${ZMQADDRESS}:${ZMQ_PORT}" \
    -zmqpubsequence="tcp://${ZMQADDRESS}:${ZMQ_PORT}" \
    -testnet=${TESTNET} \
    ${EXTRAFLAGS}
