#!/usr/bin/env bash

curl -XPUT 'localhost:9200/_ingest/pipeline/flatjson?pretty' -H 'Content-Type: application/json' -d'
{
  "description" : "Add flatjson info",
  "processors" : [
    {
      "flatjson-esplugin" : {
      }
    }
  ]
}
'

curl -XPUT 'localhost:9200/my_index/my_type/my_id?pipeline=flatjson&pretty' -H 'Content-Type: application/json' -d'
{
    "source_host": "172.18.0.1",
    "level": 6,
    "created": "2017-08-10T14:40:40.8486884Z",
    "message": "xxx",
    "type": "docker",
    "version": "1.1",
    "command": "java -Djava.security.egd=file:/dev/./urandom -Dspring.profiles.active=docker -jar /spring-petclinic.jar",
    "image_name": "treeptik/petclinic",
    "@timestamp": "2017-08-10T14:40:53.591Z",
    "container_name": "pensive_yalow",
    "message": "{\"timeMillis\":1502376053591,\"thread\":\"main\",\"level\":\"INFO\",\"loggerName\":\"org.springframework.boot.actuate.endpoint.mvc.EndpointHandlerMapping\",\"message\":\"Mapped \\\"{[/manage/dump || /manage/dump.json],methods=[GET],produces=[application/vnd.spring-boot.actuator.v1+json || application/json]}\\\" onto public java.lang.Object org.springframework.boot.actuate.endpoint.mvc.EndpointMvcAdapter.invoke()\",\"endOfBatch\":false,\"loggerFqcn\":\"org.apache.commons.logging.impl.SLF4JLocationAwareLog\",\"threadId\":1,\"threadPriority\":5}\r",
    "host": "moby",
    "@version": "1",
    "tag": "04156ee39f3c",
    "image_id": "sha256:7d5a542e1374d67b2d8a0108ebfa3543ee125cf336f965934e8ad8cf0e2978df",
    "container_id": "04156ee39f3c665ec88fedcbc112a6550e9b4b018bfbb30f251a77d399881567"
}
'

curl -XGET 'localhost:9200/my_index/my_type/my_id?pretty'


