FROM debian:10-slim AS build

WORKDIR /home

# Install packages
ENV DOGECOIN_LATEST_RELEASE=https://api.github.com/repos/dogecoin/dogecoin/releases/latest

RUN apt update && apt-get install -y --no-install-recommends build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libprotobuf-dev protobuf-compiler libqrencode-dev libdb5.3++-dev libdb5.3++ libdb5.3-dev libzmq3-dev libminiupnpc-dev libboost-thread-dev clang cmake gdb wget python3 ca-certificates curl git make && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

# Install node
RUN export DOGECOIN_VERSION=$(curl -s ${DOGECOIN_LATEST_RELEASE} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])") && \
    echo "Installing version: $DOGECOIN_VERSION" && \
    git clone -b ${DOGECOIN_VERSION} https://github.com/dogecoin/dogecoin 

RUN cd dogecoin && \
    ./autogen.sh && \
    ./configure --disable-wallet --without-gui && \
    make && \
    make install && \
    strip /usr/local/bin/dogecoind && \
    cd ../ && \
    rm -rf dogecoin

FROM debian:10-slim

RUN apt update && apt-get install -y --no-install-recommends build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libprotobuf-dev protobuf-compiler libqrencode-dev libdb5.3++-dev libdb5.3++ libdb5.3-dev libzmq3-dev libminiupnpc-dev libboost-thread-dev clang cmake gdb wget python3 curl git make && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

COPY --from=build /usr/local/bin/dogecoind /usr/local/bin
COPY ./run.sh ./run.sh
RUN chmod 777 ./run.sh

EXPOSE 22554

ENTRYPOINT ./run.sh

