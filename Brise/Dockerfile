# syntax=docker/dockerfile:1
FROM golang:1.19.1 as BUILDER

RUN apt update && apt install -y build-essential git
WORKDIR /geth
ARG VERSION=v1.10.23
RUN git clone --quiet --branch ${VERSION} --depth 1 https://github.com/ethereum/go-ethereum .
RUN go run build/ci.go install -static ./cmd/geth

FROM alpine:latest

ENV HTTP_PORT=8545
ENV WS_PORT=8546
ENV ADDRESS=0.0.0.0
ENV PORT=30303
ENV SYNCMODE=snap
ENV EXTRAFLAGS=""
ENV DATA_DIR=/root/node
ENV BOOTNODES=enode://5b0a02ce4e3c3f182d1c9aaf06c02d2541f99c9f004406cab3ee8079eaed4afbca08f0acdd615a17e793d3ebfdd428ba6a644ab48e1a2f3e15c17265d5964fe7@141.95.124.34:40605,enode://4269e56c73d4ecac60c6087d2bfe567121f6aa04d2c742e6992bce1ad7040db3d935cc1bf3758d90247a53252eec3fe4a402282af70c06a3d32d13b92aefcb5f@141.95.124.35:40605,enode://c720ce64279be5fbc68e10991fa9d47beb7131a8b57468d44c38154e243b6a669f5016db00f7640ba94698db586f056d16bb1f3c71e0d220b9a1858307b58dd8@146.59.54.152:40605,enode://1b73b153b934ec9ef5eb566b571787b129950e920d85c5696a07f4016d447b107e439030596805b437f4319d9d8ac43264ea05897a6b0b7e6161fba177dbd2fc@146.59.84.163:40605

WORKDIR /root/
COPY --from=BUILDER /geth/build/bin/geth /usr/local/bin/

RUN apk add --no-cache bash \
    && wget https://raw.githubusercontent.com/Bitgert/brise-chain/master/brise_mainnet.json
RUN mkdir ${DATA_DIR}
RUN geth --datadir ${DATA_DIR} init brise_mainnet.json

EXPOSE 8545 8546 8551 30303 30303/udp



ENTRYPOINT geth --datadir ${DATA_DIR}  --port ${PORT} --http --http.addr ${ADDRESS} --http.port=${HTTP_PORT} --http.vhosts '*' --http.corsdomain '*' --http.api 'personal,eth,net,web3,personal,admin,miner,txpool,debug' --ws --ws.addr ${ADDRESS} --ws.port ${WS_PORT} --ws.origins '*' --bootnodes ${BOOTNODES} --networkid 32520 
