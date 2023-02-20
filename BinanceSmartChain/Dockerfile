FROM debian:9 AS build

WORKDIR /home

ENV BINANCE_LATEST_RELEASE=https://api.github.com/repos/bnb-chain/bsc/releases/latest

RUN apt update -y && apt install -y wget curl unzip

# https://docs.bnbchain.org/docs/validator/fullnode

RUN wget $(curl -s ${BINANCE_LATEST_RELEASE} |grep browser_ |grep geth_linux |cut -d\" -f4)
RUN wget $(curl -s ${BINANCE_LATEST_RELEASE} |grep browser_ |grep mainnet |cut -d\" -f4)
RUN unzip mainnet.zip && \
    chmod +x geth_linux && \
    ln -s /home/geth_linux /usr/local/bin

FROM debian:9

WORKDIR /home

EXPOSE 18545 18546 30311 30311/udp

COPY config.toml ./config.toml
COPY ./run.sh ./run.sh
COPY --from=build /usr/local/bin/geth_linux /usr/local/bin
COPY --from=build /home/genesis.json /home/genesis.json
RUN mkdir ./init-dir && geth_linux --datadir ./init-dir init genesis.json && cp -rn ./init-dir /root/.ethereum

ENTRYPOINT ./run.sh
