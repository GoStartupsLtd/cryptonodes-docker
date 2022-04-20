FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y wget openjdk-8-jre-headless

WORKDIR /root/tron

RUN wget https://github.com/tronprotocol/java-tron/releases/download/GreatVoyage-v4.4.4/FullNode.jar
RUN wget https://raw.githubusercontent.com/tronprotocol/tron-deployment/master/main_net_config.conf

ENTRYPOINT java -jar FullNode.jar --witness -c main_net_config.conf
