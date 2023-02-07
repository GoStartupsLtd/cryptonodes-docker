FROM debian:9

ENV RPC_USER=user
ENV RPC_PASS=pass
ENV RPC_PORT=8332
ENV RPC_ALLOW_IP=127.0.0.1
ENV ZMQ_PORT=29000
ENV ZMQ_ADDRESS=localhost
ENV TESTNET=0
ENV EXTRAFLAGS=''
ENV DEBIAN_FRONTEND=noninteractive
ENV RPC_BIND=0.0.0.0

RUN apt update && apt install curl gpg wget python3 -y

COPY ./install.sh ./install.sh
RUN chmod +x ./install.sh

RUN export BITCOIN_VERSION=$(curl -s https://api.github.com/repos/bitcoin/bitcoin/releases/latest | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'].replace('v', ''))") && ./install.sh

EXPOSE ${RPC_PORT}
EXPOSE ${ZMQ_PORT}

ENTRYPOINT bitcoind -rpcuser="${RPC_USER}" \
    -rpcpassword="${RPC_PASS}" \
    -rpcport="${RPC_PORT}" \
    -rpcallowip="${RPC_ALLOW_IP}" \
    -rpcbind="${RPC_BIND}" \
    -listen \
    -server \
    -zmqpubhashblock="tcp://${ZMQ_ADDRESS}:${ZMQ_PORT}" \
    -zmqpubhashtx="tcp://${ZMQ_ADDRESS}:${ZMQ_PORT}" \
    -zmqpubrawblock="tcp://${ZMQ_ADDRESS}:${ZMQ_PORT}" \
    -zmqpubrawtx="tcp://${ZMQ_ADDRESS}:${ZMQ_PORT}" \
    -zmqpubsequence="tcp://${ZMQ_ADDRESS}:${ZMQ_PORT}" \
    -testnet=${TESTNET} \
    ${EXTRAFLAGS}
