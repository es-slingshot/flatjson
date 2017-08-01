#!/usr/bin/env bash

export CONTAINER_NAME="elastic-flatjson-ci"
export ELASTIC_HEALTHCHECK="http://localhost:9200/_cluster/health?wait_for_status=green&timeout=30s"
export ELASTIC_DEPLOY_CMD=''

if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]
then
    if [ "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
        # cleanup
        docker rm -vf elastic-flatjson-ci
    fi
    # run your container
    docker run -d \
       --name $CONTAINER_NAME \
       -e xpack.security.enabled=false \
       -e xpack.monitoring.enabled=false \
       -e xpack.graph.enabled=false \
       -e xpack.watcher.enabled=false \
       -e ES_JAVA_OPTS="-Xmx1g -Xms1g" \
       -v $PWD/target/releases:/releases \
       -p 9200:9200 \
       -l org.slingshot.plugin=flatjson \
       docker.elastic.co/elasticsearch/elasticsearch:5.5.1
fi

# Check the cluster start
for i in {1..60}
do
    STATUS=$(curl -s -o /dev/null -w '%{http_code}' $ELASTIC_HEALTHCHECK)
    echo "[$STATUS] : $ELASTIC_HEALTHCHECK"
    if [ $STATUS -eq 200 ]
    then
        # If cluster is ok, so copy the deploy script and deploy the plugin
        docker cp es-deploy.sh $CONTAINER_NAME:/usr/share/elasticsearch/bin/es-deploy.sh
        docker exec $CONTAINER_NAME /usr/share/elasticsearch/bin/es-deploy.sh
        exit 0
    fi
    sleep 1
done

exit 1
