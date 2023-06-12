FROM ubuntu:20.04 AS build

# Needed for exchain installation script
ENV GO_VERSION=1.19.2
ENV ROCKSDB_VERSION=v6.27.3
ENV GO_PATH=/go
ENV DEBIAN_FRONTEND=noninteractive

# https://github.com/okx/exchain/releases/
ENV EXCHAIN_NODE_VERSION=

WORKDIR /home

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y wget python3 curl bzip2 liblz4-dev zstd libzstd-dev bash zlib1g-dev git make g++ gcc cmake gnutls-bin clang libsnappy-dev libgflags-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

RUN if [ -z "$EXCHAIN_NODE_VERSION" ]; then \
    OKT_VERSION=v1.6.7.7; \
    else \
    OKT_VERSION=$(curl -s ${OKT_LATEST_RELEASE} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])"); \
    fi && \
    echo "Installing version: $OKT_VERSION" && \
    git clone -b $OKT_VERSION https://github.com/okx/exchain.git

RUN cd exchain && \
    ./dev/auto-install.sh && \
    strip /root/go/bin/exchaind && \
    cd ../ && \
    rm -rf exchain

FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y curl wget libsnappy-dev libgflags-dev

WORKDIR /home

EXPOSE 8549 8550 8551

# COPY --from=build /usr/lib/librocksdb.so.6.27 /usr/lib/
# COPY --from=build /usr/lib/librocksdb.so.6 /usr/lib/
COPY --from=build /usr/lib/librocksdb.so /usr/lib/
COPY --from=build /root/go/pkg/mod/github.com/!cosm!wasm/wasmvm@v1.0.0/api/libwasmvm.x86_64.so /usr/lib/

COPY --from=build /root/go/bin/exchaind /usr/local/bin/

COPY ./run.sh ./run.sh
RUN chmod 777 ./run.sh

ENTRYPOINT ./run.sh
