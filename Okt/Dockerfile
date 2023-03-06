FROM ubuntu:20.04 AS build

ENV GO_VERSION=1.19.2
ENV ROCKSDB_VERSION=v6.27.3
ENV GO_PATH=/go
ENV OKT_LATEST_VERSION=https://api.github.com/repos/okx/exchain/releases/latest
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home

# At the current time of writing this Dockerfile, there are no nodes available on newer versions upward of 1.6.7.7, so we revert to that version.
ENV BEFORE_HARD_FORK=true

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y wget python3 curl bzip2 liblz4-dev zstd libzstd-dev bash zlib1g-dev git make g++ gcc cmake gnutls-bin clang libsnappy-dev libgflags-dev

RUN if [ "$BEFORE_HARD_FORK" = "true" ]; then \
    OKT_VERSION=v1.6.7.7; \
    else \
    OKT_VERSION=$(curl -s ${OKT_LATEST_VERSION} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])"); \
    fi && \
    echo "Installing version: $OKT_VERSION" && \
    git clone https://github.com/okx/exchain.git && \
    cd exchain && \
    git checkout $OKT_VERSION && \
    ./dev/auto-install.sh

FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y curl

WORKDIR /home

EXPOSE 8549 8550 8551

COPY ./run.sh ./run.sh
COPY --from=build /usr /usr
COPY --from=build root/go/bin/exchaind /usr/local/bin/
COPY --from=build /lib/ /lib/
COPY --from=build /root/go/ /root/go/

ENTRYPOINT ./run.sh
