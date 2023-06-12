FROM debian:10-slim AS build

WORKDIR /home

ENV LITECOIN_LATEST_RELEASE=https://api.github.com/repos/litecoin-project/litecoin/releases/latest

# Install packages
RUN apt update && apt-get install -y --no-install-recommends ca-certificates wget build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 libevent-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev libfmt-dev clang cmake gdb curl git make libssl-dev libdb++-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

# Install node
RUN export LITECOIN_VERSION=$(curl -s ${LITECOIN_LATEST_RELEASE} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])") && \
    echo "Installing version: $LITECOIN_VERSION" && \
    git clone -b ${LITECOIN_VERSION} https://github.com/litecoin-project/litecoin

RUN cd litecoin && \
    ./autogen.sh && \
    ./configure --disable-wallet --without-gui && \
    make && \
    make install && \
    strip /usr/local/bin/litecoind && \
    cd ../ && \
    rm -rf litecoin

FROM debian:10-slim

WORKDIR /home

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates python3 libevent-dev libboost-system-dev libboost-filesystem-dev libboost-thread-dev libzmq3-dev libssl-dev libdb++-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

COPY --from=build /usr/local/bin/litecoind /usr/local/bin
COPY ./run.sh ./run.sh
RUN chmod 777 ./run.sh

EXPOSE 22556

ENTRYPOINT ./run.sh
