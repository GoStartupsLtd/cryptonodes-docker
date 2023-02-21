FROM debian:10 AS build

WORKDIR /home

RUN apt update && apt upgrade -y && apt install -y libb2-dev curl gpg wget libssl-dev build-essential cmake git libboost-chrono-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev libevent-dev libminiupnpc-dev libzmq3-dev help2man ninja-build python3 apt-transport-https ca-certificates gnupg software-properties-common libtool autoconf autotools-dev pkg-config bsdmainutils

ENV BITCOIN_GOLD_LATEST_VERSION=https://api.github.com/repos/BTCGPU/BTCGPU/releases/latest

RUN export BITCOIN_GOLD_VERSION=$(curl -s ${BITCOIN_GOLD_LATEST_VERSION} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'].replace('v', ''))") && \
    echo "Installing version: $BITCOIN_GOLD_VERSION" && \
    git clone https://github.com/BTCGPU/BTCGPU && \
    cd BTCGPU && \
    git checkout v${BITCOIN_GOLD_VERSION} && \
    ./autogen.sh && \
    ./configure --disable-wallet --without-gui && \
    make && \
    make install

FROM debian:10

WORKDIR /home

RUN apt update && apt upgrade -y && apt install -y libb2-dev curl gpg wget libssl-dev build-essential cmake git libboost-chrono-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev libevent-dev libminiupnpc-dev libzmq3-dev help2man ninja-build python3 apt-transport-https ca-certificates gnupg software-properties-common libtool autoconf autotools-dev pkg-config bsdmainutils

COPY ./run.sh ./run.sh
COPY --from=build /usr/local/bin/bgoldd /usr/local/bin

EXPOSE 8333

ENTRYPOINT ./run.sh