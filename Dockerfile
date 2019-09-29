FROM ubuntu:bionic
LABEL maintainer="Elliot Wright <wright.elliot@gmail.com>"

ARG SERVER_VERSION=1.12.1.1

COPY entrypoint.sh /opt/mcbuild/entrypoint.sh

RUN set -x \
    && apt-get update \
    && apt-get install -y curl unzip wget \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -d /opt/mcserver -u 1000 -m -s /bin/bash mcserver \
    && mkdir -p /opt/mcbuild \
    && mkdir -p /opt/mcserver \
    && cd /opt/mcbuild \
    && wget https://minecraft.azureedge.net/bin-linux/bedrock-server-${SERVER_VERSION}.zip \
    && unzip bedrock-server-${SERVER_VERSION}.zip \
    && rm bedrock-server-${SERVER_VERSION}.zip \
    && chown -R mcserver: /opt/mcbuild \
    && chown -R mcserver: /opt/mcserver \
    && chmod +x /opt/mcbuild/entrypoint.sh

USER mcserver

VOLUME /opt/mcserver

ENTRYPOINT ["/opt/mcbuild/entrypoint.sh"]
