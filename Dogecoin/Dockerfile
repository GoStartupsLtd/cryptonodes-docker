FROM golang:1.19-buster

WORKDIR /home

ENV DOGECOIN_LATEST_RELEASE=https://api.github.com/repos/dogecoin/dogecoin/releases/latest

RUN apt update && apt upgrade -y && apt-get install -y --no-install-recommends build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libprotobuf-dev protobuf-compiler libqrencode-dev libdb5.3++-dev libdb5.3++ libdb5.3-dev libzmq3-dev libminiupnpc-dev libboost-thread-dev clang cmake gdb wget python3 curl git make 

RUN export DOGECOIN_VERSION=$(curl -s ${DOGECOIN_LATEST_RELEASE} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])") && \
    echo "Installing version: $DOGECOIN_VERSION" && \
    git clone https://github.com/dogecoin/dogecoin && \
    cd dogecoin && \
    git checkout ${DOGECOIN_VERSION} && \
    ./autogen.sh && \
    ./configure --disable-wallet --without-gui && \
    make && \
    make install

EXPOSE 22554

COPY ./run.sh ./run.sh

ENTRYPOINT ./run.sh
