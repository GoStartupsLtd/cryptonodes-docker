FROM debian:10-slim AS build

WORKDIR /home

RUN apt update && apt install wget python3 curl git make gcc ca-certificates -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

# Install Golang
RUN curl -L https://go.dev/dl/go1.19.9.linux-amd64.tar.gz -o golang.tar.gz && \
    tar -C /usr/local -xzf golang.tar.gz && \
    rm golang.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

ENV KCC_LATEST_VERSION=https://api.github.com/repos/kcc-community/kcc/releases/latest

RUN export KCC_VERSION=$(curl -s ${KCC_LATEST_VERSION} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])") && \
    echo "Installing version: $KCC_VERSION" && \
    git clone -b ${KCC_VERSION} https://github.com/kcc-community/kcc

RUN cd kcc && \
    make geth && \
    cp /home/kcc/build/bin/geth /usr/local/bin && \
    strip /usr/local/bin/geth && \
    cd ../ && \
    rm -rf kcc

FROM debian:10-slim

WORKDIR /home

RUN apt update && apt upgrade -y && apt install -y curl gpg && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

EXPOSE 8547 8548 30303 30303/udp

COPY --from=build /usr/local/bin/geth /usr/local/bin/
COPY ./run.sh ./run.sh

ENTRYPOINT ./run.sh
