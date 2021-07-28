# elasticsearch

[![Build Status](https://drone.owncloud.com/api/badges/owncloud-ops/elasticsearch/status.svg)](https://drone.owncloud.com/owncloud-ops/elasticsearch/)
[![Docker Hub](https://img.shields.io/badge/docker-latest-blue.svg?logo=docker&logoColor=white)](https://hub.docker.com/r/owncloudops/elasticsearch)

Custom Docker image for [ElasticSearch](https://github.com/elastic/elasticsearch/).

## Ports

- 9200
- 9300

## Volumes

- /usr/share/elasticsearch/data
- /usr/share/elasticsearch/backup
- /usr/share/elasticsearch/log

## Bundled Plugins

- repository-s3
- ingest-attachment

## Environment Variables

```Shell
ELASTICSEARCH_CLUSTER_NAME=elasticsearch
ELASTICSEARCH_CLUSTER_MODE=false
# Comma-separated list
ELASTICSEARCH_INITIAL_MASTER_NODES=elastic-node1
ELASTICSEARCH_NODE_NAME=elastic-node1
ELASTICSEARCH_NODE_MASTER=true
ELASTICSEARCH_NODE_DATA=true
ELASTICSEARCH_NODE_INGEST=true
# Comma-separated list
ELASTICSEARCH_DISCOVERY_SEED_HOSTS=elastic-node1
ELASTICSEARCH_NETWORK_HOST=0.0.0.0
ELASTICSEARCH_NETWORK_PUBLISH_HOST=
ELASTICSEARCH_BOOTSTRAP_MEMORY_LOCK=true
ELASTICSEARCH_HTTP_PORT=9200
ELASTICSEARCH_HTTP_COMPRESSION=true

ELASTICSEARCH_XPACK_SECURITY_ENABLED=false
# If you enable xpack on a production mode cluster, transport ssl is mandatory
# and need to be configured.
ELASTICSEARCH_XPACK_SECURITY_TRANSPORT_SSL_ENABLED=false
ELASTICSEARCH_XPACK_SECURITY_TRANSPORT_SSL_KEY=node-key.pem
ELASTICSEARCH_XPACK_SECURITY_TRANSPORT_SSL_CERTIFICATE=node.pem
ELASTICSEARCH_XPACK_SECURITY_TRANSPORT_SSL_CERTIFICATE_AUTHORITIES=root-ca.pem
ELASTICSEARCH_XPACK_SECURITY_HTTP_SSL_ENABLED=false
ELASTICSEARCH_XPACK_SECURITY_HTTP_SSL_KEY=node-key.pem
ELASTICSEARCH_XPACK_SECURITY_HTTP_SSL_CERTIFICATE=node.pem
ELASTICSEARCH_XPACK_SECURITY_HTTP_SSL_CERTIFICATE_AUTHORITIES=root-ca.pem

# Password for the default `elastic` user
ELASTICSEARCH_PASSWORD=

ELASTICSEARCH_ROOT_LOG_LEVEL=info
ELASTICSEARCH_JVM_HEAP_SIZE=512m

ELASTICSEARCH_S3_CLIENT_DEFAULT_ACCESS_KEY=
ELASTICSEARCH_S3_CLIENT_DEFAULT_SECRET_KEY=
```

## Build

```Shell
docker build -f Dockerfile -t elasticsearch:latest .
```

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](https://github.com/owncloud-ops/elasticsearch/blob/master/LICENSE) file for details.
