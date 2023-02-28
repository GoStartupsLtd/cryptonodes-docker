FROM golang:1.19-buster AS build

WORKDIR /home

RUN apt update && apt install wget python3 curl git make -y

ENV KCC_LATEST_VERSION=https://api.github.com/repos/kcc-community/kcc/releases/latest

RUN export KCC_VERSION=$(curl -s ${KCC_LATEST_VERSION} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])") && \
    echo "Installing version: $KCC_VERSION" && \
    git clone https://github.com/kcc-community/kcc && \
    cd kcc && \
    git checkout ${KCC_VERSION} && \
    make geth && \
    ln -s /home/kcc/build/bin/geth /usr/local/bin

FROM debian:10

WORKDIR /home

RUN apt update && apt upgrade -y && apt install -y curl gpg

EXPOSE 8547 8548 30303 30303/udp

COPY --from=build /usr/local/bin/geth /usr/local/bin/
COPY ./run.sh ./run.sh

ENTRYPOINT ./run.sh
