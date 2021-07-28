FROM elasticsearch:7.10.1@sha256:7cd88158f6ac75d43b447fdd98c4eb69483fa7bf1be5616a85fe556262dc864a

LABEL maintainer="ownCloud GmbH"
LABEL org.opencontainers.image.authors="ownCloud GmbH"
LABEL org.opencontainers.image.title="ElasticSearch"
LABEL org.opencontainers.image.url="https://github.com/owncloud-ops/elasticsearch"
LABEL org.opencontainers.image.source="https://github.com/owncloud-ops/elasticsearch"
LABEL org.opencontainers.image.documentation="https://github.com/owncloud-ops/elasticsearch"

ARG GOMPLATE_VERSION
ARG ELASTICSEARCH_PLUGINS


# renovate: datasource=github-releases depName=hairyhenderson/gomplate
ENV GOMPLATE_VERSION="${GOMPLATE_VERSION:-v3.9.0}"

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
