FROM debian:10-slim AS build

WORKDIR /home

# Install packages
RUN apt update && apt install wget python3 ca-certificates curl gcc git unzip libstdc++6 make libgmp-dev build-essential jq -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

# # Install Golang
RUN curl -L https://go.dev/dl/go1.19.linux-amd64.tar.gz -o golang.tar.gz && \
    tar -C /usr/local -xzf golang.tar.gz && \
    rm golang.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"



# Note - if you want to install a custom version replace releases/latest with releases/tags/tag-name
ENV BINANCE_LATEST_RELEASE=https://api.github.com/repos/bnb-chain/bsc/releases/latest

ENV CGO_CFLAGS="-O -D__BLST_PORTABLE__"
ENV CGO_CFLAGS_ALLOW="-O -D__BLST_PORTABLE__"

RUN export BSC_VERSION=$(curl -s ${BINANCE_LATEST_RELEASE} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])") && \
    echo "Installing version: $BSC_VERSION" && \
    git clone -b ${BSC_VERSION} https://github.com/bnb-chain/bsc

RUN cd bsc && \
    make geth && \
    cp build/bin/geth /usr/local/bin && \
    strip /usr/local/bin/geth && \
    cd ../ && \
    rm -rf bsc

RUN wget $(curl -s ${BINANCE_LATEST_RELEASE} | jq -r '.assets[] | select(.name | test("mainnet")) | .browser_download_url') -O mainnet.zip && \
    unzip mainnet.zip && \
    rm mainnet.zip

FROM debian:10-slim

WORKDIR /home

COPY --from=build /usr/local/bin/geth /usr/local/bin/geth
COPY --from=build /home/config.toml /home/config.toml
COPY --from=build /home/genesis.json /home/genesis.json

RUN mkdir ./init-dir && geth --datadir ./init-dir init genesis.json && cp -rn ./init-dir /root/.ethereum

EXPOSE 18545 18546 30311 30311/udp

COPY ./run.sh ./run.sh
RUN chmod 777 ./run.sh

ENTRYPOINT ./run.sh
