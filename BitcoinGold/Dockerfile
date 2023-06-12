FROM debian:10-slim AS build

WORKDIR /home

# Install packages
RUN apt update && apt install libb2-dev curl gpg wget libssl-dev build-essential cmake git libboost-chrono-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev libevent-dev libminiupnpc-dev libzmq3-dev help2man ninja-build python3 apt-transport-https ca-certificates gnupg software-properties-common libtool autoconf autotools-dev pkg-config bsdmainutils -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

# Install latest Bitcoin Gold
ENV BITCOIN_GOLD_LATEST_RELEASE=https://api.github.com/repos/BTCGPU/BTCGPU/releases/latest

RUN export BITCOIN_GOLD_VERSION=$(curl -s ${BITCOIN_GOLD_LATEST_RELEASE} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])") && \
    echo "Installing version: $BITCOIN_GOLD_VERSION" && \
    git clone -b ${BITCOIN_GOLD_VERSION} https://github.com/BTCGPU/BTCGPU

RUN cd BTCGPU && \
    ./autogen.sh && \
    ./configure --disable-wallet --without-gui && \
    make && \
    make install && \
    cd ../ && \
    rm -rf BTCGPU && \
    strip /usr/local/bin/bgoldd

FROM debian:10-slim

WORKDIR /home

RUN apt update && apt upgrade -y && apt install -y libb2-dev curl gpg wget libssl-dev build-essential cmake git libboost-chrono-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev libevent-dev libminiupnpc-dev libzmq3-dev help2man ninja-build python3 apt-transport-https ca-certificates gnupg software-properties-common libtool autoconf autotools-dev pkg-config bsdmainutils && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

COPY ./run.sh ./run.sh
RUN chmod 777 ./run.sh

COPY --from=build /usr/local/bin/bgoldd /usr/local/bin

EXPOSE 8336

ENTRYPOINT ./run.sh
