FROM debian:9

WORKDIR /home/bsc

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y wget curl unzip

# https://docs.bnbchain.org/docs/validator/fullnode

RUN wget $(curl -s https://api.github.com/repos/bnb-chain/bsc/releases/latest |grep browser_ |grep geth_linux |cut -d\" -f4)
RUN wget $(curl -s https://api.github.com/repos/bnb-chain/bsc/releases/latest |grep browser_ |grep mainnet |cut -d\" -f4)
RUN unzip mainnet.zip
RUN chmod +x geth_linux
# Pull Geth into a second stage deploy alpine container

ENV HTTP_PORT=18545
ENV WS_PORT=18546
ENV ADDRESS=0.0.0.0
ENV PORT=30311
ENV SYNCMODE=snap
ENV EXTRAFLAGS=""

EXPOSE 18545 18546 30311 30311/udp

COPY config.toml ./config.toml
COPY ./run.sh ./run.sh
RUN mkdir ./init-dir && ./geth_linux --datadir ./init-dir init genesis.json && cp -rn ./init-dir /root/.ethereum

ENTRYPOINT ./run.sh
