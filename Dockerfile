FROM ubuntu:bionic
LABEL maintainer="Elliot Wright <wright.elliot@gmail.com>"

ARG SERVER_VERSION=1.12.1.1

RUN set -x \
    && apt-get update \
    && apt-get install -y curl unzip wget \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -d /opt/mcserver -u 1000 -m -s /bin/bash mcserver \
    && mkdir -p /opt/mcserver \
    && cd /opt/mcserver \
    && wget https://minecraft.azureedge.net/bin-linux/bedrock-server-${SERVER_VERSION}.zip \
    && unzip bedrock-server-${SERVER_VERSION}.zip \
    && rm bedrock-server-${SERVER_VERSION}.zip \
    && chown -R mcserver: /opt/mcserver

USER mcserver

VOLUME /opt/mcserver
WORKDIR /opt/mcserver

CMD LD_LIBRARY_PATH=. ./bedrock_server
