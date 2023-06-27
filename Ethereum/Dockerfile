FROM debian:10-slim AS build

WORKDIR /home

#  Install packages
RUN apt update && apt install wget python3 curl git libstdc++6 make gcc g++ -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

ENV ETHEREUM_LATEST_RELEASE=https://api.github.com/repos/ethereum/go-ethereum/releases/latest

# Install Golang
RUN curl -L https://go.dev/dl/go1.19.9.linux-amd64.tar.gz -o golang.tar.gz && \
    tar -C /usr/local -xzf golang.tar.gz && \
    rm golang.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

# Install node
RUN export ETHEREUM_VERSION=$(curl -s ${ETHEREUM_LATEST_RELEASE} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])") && \
    echo "Installing version: $ETHEREUM_VERSION" && \
    git clone -b ${ETHEREUM_VERSION} https://github.com/ethereum/go-ethereum

RUN cd go-ethereum && \
    make geth && \
    cp /home/go-ethereum/build/bin/geth /usr/local/bin && \
    strip /usr/local/bin/geth && \
    cd ../ && \
    rm -rf go-ethereum

RUN curl https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh --output prysm.sh && chmod +x prysm.sh

FROM debian:10-slim

WORKDIR /home

RUN apt update && apt install -y curl gpg && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

EXPOSE 8545 8546 30303 30303/udp

COPY --from=build /usr/local/bin/geth /usr/local/bin/
COPY --from=build /home/prysm.sh ./prysm.sh
COPY ./run.sh ./run.sh
RUN chmod u+x ./run.sh

ENTRYPOINT ./run.sh