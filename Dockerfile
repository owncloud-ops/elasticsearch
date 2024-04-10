FROM docker.io/amd64/elasticsearch:7.17.20@sha256:7a33c5803a065cbb7f7f00206ce1df25052fa888e699b06a34f327393f29f97c

LABEL maintainer="ownCloud GmbH"
LABEL org.opencontainers.image.authors="ownCloud GmbH"
LABEL org.opencontainers.image.title="ElasticSearch"
LABEL org.opencontainers.image.url="https://github.com/owncloud-ops/elasticsearch"
LABEL org.opencontainers.image.source="https://github.com/owncloud-ops/elasticsearch"
LABEL org.opencontainers.image.documentation="https://github.com/owncloud-ops/elasticsearch"

ARG GOMPLATE_VERSION
ARG CONTAINER_LIBRARY_VERSION
ARG ELASTICSEARCH_PLUGINS

# renovate: datasource=github-releases depName=hairyhenderson/gomplate
ENV GOMPLATE_VERSION="${GOMPLATE_VERSION:-v3.11.7}"
# renovate: datasource=github-releases depName=owncloud-ops/container-library
ENV CONTAINER_LIBRARY_VERSION="${CONTAINER_LIBRARY_VERSION:-v0.1.0}"

ADD overlay/ /

USER 0

RUN apt-get update && apt-get install -y wget curl && \
    curl -SsfL -o /usr/local/bin/gomplate "https://github.com/hairyhenderson/gomplate/releases/download/${GOMPLATE_VERSION}/gomplate_linux-amd64" && \
    curl -SsfL "https://github.com/owncloud-ops/container-library/releases/download/${CONTAINER_LIBRARY_VERSION}/container-library.tar.gz" | tar xz -C / && \
    chmod 755 /usr/local/bin/gomplate && \
    mkdir -p /usr/share/elasticsearch/backup && \
    chown -R elasticsearch:root /usr/share/elasticsearch/backup && \
    chmod 755 /usr/share/elasticsearch/backup && \
    chown -R elasticsearch:root /usr/share/elasticsearch/config && \
    chmod 750 /usr/share/elasticsearch/config && \
    for PLUGIN in ${ELASTICSEARCH_PLUGINS}; do /usr/share/elasticsearch/bin/elasticsearch-plugin install -s -b "${PLUGIN}" || exit 1; done && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

USER 1000

WORKDIR /usr/share/elasticsearch
ENTRYPOINT ["/usr/bin/entrypoint"]
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD /usr/bin/healthcheck
CMD []
