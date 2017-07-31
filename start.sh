#!/usr/bin/env bash

export ELASTIC_HEALTHCHECK="http://localhost:9200/_cluster/health?wait_for_status=green&timeout=30s"

docker run -d \
   --name elastic-flatjson-ci \
   -e xpack.security.enabled=false \
   -e xpack.monitoring.enabled=false \
   -e xpack.graph.enabled=false \
   -e xpack.watcher.enabled=false \
   -e ES_JAVA_OPTS="-Xmx1g -Xms1g" \
   -v $PWD/target/releases:/releases \
   -p 9200:9200 \
   -l org.slingshot.plugin=flatjson \
   docker.elastic.co/elasticsearch/elasticsearch:5.5.1

for i in {1..60}
do
    STATUS=$(curl -s -o /dev/null -w '%{http_code}' $HEALTHCHECK_ELASTIC)
    if [ $STATUS -eq 200 ]; then
        exit 0
    fi
    sleep 1
done

# docker exec -it elastic-flatjson-ci $ELASTIC_DEPLOY_CMD

exit 1
