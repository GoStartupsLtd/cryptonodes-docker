FROM debian:10 AS build

WORKDIR /home

RUN apt update && apt upgrade -y && apt install -y curl gpg wget libssl-dev build-essential cmake git libboost-chrono-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev libevent-dev libminiupnpc-dev libzmq3-dev help2man ninja-build python3 apt-transport-https ca-certificates gnupg software-properties-common wget


ENV BITCOIN_CASH_LATEST_VERSION=https://api.github.com/repos/bitcoin-cash-node/bitcoin-cash-node/releases/latest

RUN export BITCOIN_VERSION=$(curl -s ${BITCOIN_CASH_LATEST_VERSION} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'].replace('v', ''))") && \
    echo "Installing version: $BITCOIN_CASH_LATEST_VERSION" && \
    git clone https://github.com/bitcoin-cash-node/bitcoin-cash-node && \
    cd bitcoin-cash-node && \
    git checkout v${BITCOIN_VERSION} && \
    mkdir build && \
    cd build && \
    cmake -GNinja .. -DBUILD_BITCOIN_WALLET=OFF -DBUILD_BITCOIN_QT=OFF && \
    ninja && \
    ln -s /home/bitcoin-cash-node/build/src/bitcoind /usr/local/bin

COPY ./run.sh ./run.sh

EXPOSE 8332 29000

ENTRYPOINT ./run.sh