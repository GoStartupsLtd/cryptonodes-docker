FROM golang:1.19-buster AS build

WORKDIR /home

RUN apt update && apt install wget python3 curl git make -y

ENV ETHEREUM_LATEST_RELEASE=https://api.github.com/repos/ethereum/go-ethereum/releases/latest

RUN export ETHEREUM_VERSION=$(curl -s ${ETHEREUM_LATEST_RELEASE} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])") && \
    echo "Installing version: $ETHEREUM_VERSION" && \
    git clone https://github.com/ethereum/go-ethereum && \
    cd go-ethereum && \
    git checkout ${ETHEREUM_VERSION} && \
    make geth && \
    ln -s /home/go-ethereum/build/bin/geth /usr/local/bin

RUN curl https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh --output prysm.sh && chmod +x prysm.sh

FROM debian:9

WORKDIR /home

RUN apt update && apt upgrade -y && apt install -y curl

ENV HTTP_PORT=8545
ENV WS_PORT=8546
ENV ADDRESS=127.0.0.1
ENV PORT=30303
ENV SYNCMODE=snap
ENV EXTRAFLAGS=""

EXPOSE 8545 8546 30303 30303/udp

COPY --from=build /usr/local/bin/geth /usr/local/bin/
COPY --from=build /home/prysm.sh ./prysm.sh
COPY ./run.sh ./run.sh

ENTRYPOINT sh run.sh