# FROM golang:1.19-alpine as builder

# WORKDIR /home/
# RUN apk add --no-cache make gcc musl-dev linux-headers git

# RUN git clone https://github.com/ethereum/go-ethereum && \
#     cd go-ethereum && \
#     make geth 

# Pull Geth into a second stage deploy alpine container
FROM debian:9

# RUN apk add --no-cache ca-certificates
# COPY --from=builder /home/go-ethereum/build/bin/geth /usr/local/bin/


ENV HTTP_PORT=8545
ENV WS_PORT=8546
ENV ADDRESS=127.0.0.1
ENV PORT=30303
ENV SYNCMODE=snap
ENV EXTRAFLAGS=""

EXPOSE 8545 8546 30303 30303/udp

COPY . .
RUN apt update && apt install curl gpg wget -y
RUN wget https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.10.26-e5eb32ac.tar.gz
RUN tar xzf geth-linux-amd64-1.10.26-e5eb32ac.tar.gz
RUN mv ./geth-linux-amd64-1.10.26-e5eb32ac/geth geth
RUN chmod +x geth
RUN curl https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh --output prysm.sh && chmod +x prysm.sh

ENTRYPOINT sh run.sh

