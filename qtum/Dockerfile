FROM ubuntu:bionic

ENV BRANCH master
ENV DATA_DIR=/data
ENV CHAIN=main
ENV RPC_USER=root
ENV RPC_PASS=root
ENV RPC_PORT=3889
ENV RPC_BIND=0.0.0.0
ENV RPC_ALLOW_IP=0.0.0.0/0


RUN set -ex \
    && apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:bitcoin/bitcoin \
    && apt-get install -y -qq --no-install-recommends ca-certificates git wget apt-utils \
    && apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libgmp3-dev \
    && apt-get install -y libboost-all-dev \
    && apt-get update \
    && apt-get install -y libdb4.8-dev libdb4.8++-dev \
    && apt-get install -y libzmq3-dev \
    && rm -rf /var/lib/apt/lists/*

# install qtum from github
RUN cd /tmp && git clone --recursive https://github.com/qtumproject/qtum.git \
    && cd qtum \
    && git checkout $BRANCH \
    && ./autogen.sh \
    && ./configure --without-gui --with-gmp=/usr/lib \
    && make -j4 \
    && make check \
    && make install  \
    && rm -rf /tmp/*

# create data directory
RUN mkdir $DATA_DIR \
    && ln -sfn $DATA_DIR /root/.qtum \
    VOLUME ${DATA_DIR}

EXPOSE 3888 3889 13888 13889

CMD ["qtumd -chain=${CHAIN} \
    -datadir=${DATA_DIR} \
    -rpcuser=${RPC_USER} \
    -rpcpassword=${RPC_PASS} \
    -rpcport=${RPC_PORT} \
    -rpcbind=${RPC_BIND} \
    -rpcallowip=${RPC_ALLOW_IP} \
    ${EXTRAFLAGS}"]


#More qtum params: https://github.com/qtumproject/qtum/blob/1a926b980f03e97322c7dd787835bec1730f35d2/contrib/debian/examples/qtum.conf