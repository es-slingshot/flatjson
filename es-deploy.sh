#!/usr/bin/env bash

export CONTAINER_NAME="elastic-flatjson-ci"
export ELASTIC_BIN="/usr/share/elasticsearch/bin"

$ELASTIC_BIN/elasticsearch-plugin install \
                                  file:///releases/flatjson-esplugin-1.0-SNAPSHOT.zip

