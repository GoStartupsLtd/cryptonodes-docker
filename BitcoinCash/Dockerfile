FROM debian:10-slim AS build

WORKDIR /home

# Install packages
RUN apt update && apt install curl gpg wget libssl-dev build-essential cmake git libboost-chrono-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev libevent-dev libminiupnpc-dev libzmq3-dev help2man ninja-build python3 apt-transport-https ca-certificates gnupg software-properties-common binutils -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

# Install node
ENV BITCOIN_CASH_LATEST_RELEASE=https://api.github.com/repos/bitcoin-cash-node/bitcoin-cash-node/releases/latest

RUN export BITCOIN_CASH_VERSION=$(curl -s ${BITCOIN_CASH_LATEST_RELEASE} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])") && \
    echo "Installing version: $BITCOIN_CASH_VERSION" && \
    git clone -b ${BITCOIN_CASH_VERSION} https://github.com/bitcoin-cash-node/bitcoin-cash-node

RUN cd bitcoin-cash-node && \
    mkdir build && \
    cd build && \
    cmake -GNinja .. -DBUILD_BITCOIN_WALLET=OFF -DBUILD_BITCOIN_QT=OFF && \
    ninja && \
    # Strips debug information from the binary making it smaller
    strip src/bitcoind && \
    cp src/bitcoind /usr/local/bin && \
    cd ../../ && \
    rm -rf bitcoin-cash-node

FROM debian:10-slim

WORKDIR /home

RUN apt update && apt upgrade -y && apt install -y curl gpg wget libssl-dev build-essential cmake git libboost-chrono-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev libevent-dev libminiupnpc-dev libzmq3-dev help2man ninja-build python3 apt-transport-https ca-certificates gnupg software-properties-common wget && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

COPY --from=build /usr/local/bin/bitcoind /usr/local/bin
COPY ./run.sh ./run.sh
RUN chmod 777 ./run.sh

EXPOSE 8334

ENTRYPOINT ./run.sh