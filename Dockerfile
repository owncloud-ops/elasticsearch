FROM elasticsearch:7.14.2@sha256:f05ab7f4d2aa5040813a0ea4eb76fa99bb31459937a4539efe2f2c2dbb2109fb

LABEL maintainer="ownCloud GmbH"
LABEL org.opencontainers.image.authors="ownCloud GmbH"
LABEL org.opencontainers.image.title="ElasticSearch"
LABEL org.opencontainers.image.url="https://github.com/owncloud-ops/elasticsearch"
LABEL org.opencontainers.image.source="https://github.com/owncloud-ops/elasticsearch"
LABEL org.opencontainers.image.documentation="https://github.com/owncloud-ops/elasticsearch"

ARG GOMPLATE_VERSION
ARG ELASTICSEARCH_PLUGINS


# renovate: datasource=github-releases depName=hairyhenderson/gomplate
ENV GOMPLATE_VERSION="${GOMPLATE_VERSION:-v3.10.0}"

ADD overlay/ /

USER 0

RUN yum install -y -q wget curl && \
    curl -SsL -o /usr/local/bin/gomplate "https://github.com/hairyhenderson/gomplate/releases/download/${GOMPLATE_VERSION}/gomplate_linux-amd64-slim" && \
    chmod 755 /usr/local/bin/gomplate && \
    mkdir -p /usr/share/elasticsearch/backup && \
    chown -R elasticsearch:root /usr/share/elasticsearch/backup && \
    chmod 755 /usr/share/elasticsearch/backup && \
    for PLUGIN in ${ELASTICSEARCH_PLUGINS}; do /usr/share/elasticsearch/bin/elasticsearch-plugin install -s -b "${PLUGIN}" || exit 1; done && \
    yum clean all

USER 1000

WORKDIR /usr/share/elasticsearch
ENTRYPOINT ["/usr/bin/entrypoint"]
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD /usr/bin/healthcheck
CMD []
