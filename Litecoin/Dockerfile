FROM golang:1.19-buster AS build

WORKDIR /home

ENV LITECOIN_LATEST_RELEASE=https://api.github.com/repos/litecoin-project/litecoin/releases/latest

RUN apt update && apt upgrade -y && apt-get install -y --no-install-recommends wget build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 libevent-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev libfmt-dev clang cmake gdb curl git make libzmq3-dev libssl-dev libdb++-dev

RUN export LITECOIN_VERSION=$(curl -s ${LITECOIN_LATEST_RELEASE} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])") && \
    echo "Installing version: $LITECOIN_VERSION" && \
    git clone https://github.com/litecoin-project/litecoin && \
    cd litecoin && \
    git checkout ${LITECOIN_VERSION} && \
    ./autogen.sh && \
    ./configure --disable-wallet --without-gui && \
    make && \
    make install

FROM debian:10

WORKDIR /home

RUN apt update && apt upgrade -y && apt-get install -y --no-install-recommends wget build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 libevent-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev clang cmake gdb curl git make libzmq3-dev libssl-dev libdb++-dev

COPY ./run.sh ./run.sh
COPY --from=build /usr/local/bin/litecoind /usr/local/bin

EXPOSE 22556

ENTRYPOINT ./run.sh
