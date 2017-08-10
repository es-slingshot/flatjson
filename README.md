# flatjson

To run integration tests
```
mvn verify -Pdocker 
```

# INPUT

```
curl -XPUT 'localhost:9200/_ingest/pipeline/flatjson?pretty' -H 'Content-Type: application/json' -d'
{
  "description" : "Add flatjson info",
  "processors" : [
    {
      "flatjson-esplugin" : {
        "jsonField": "message",
        "prefix": "msg"
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
```

# OUTPUT

````
curl -XGET 'localhost:9200/my_index/my_type/my_id?pretty'

{
  "_index" : "my_index",
  "_type" : "my_type",
  "_id" : "my_id",
  "_version" : 1,
  "result" : "created",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "created" : true
}
{
  "_index" : "my_index",
  "_type" : "my_type",
  "_id" : "my_id",
  "_version" : 1,
  "found" : true,
  "_source" : {
    "msg_threadPriority" : 5,
    "type" : "docker",
    "image_name" : "treeptik/petclinic",
    "host" : "moby",
    "@version" : "1",
    "tag" : "04156ee39f3c",
    "msg_timeMillis" : 1502376053591,
    "msg_loggerFqcn" : "org.apache.commons.logging.impl.SLF4JLocationAwareLog",
    "source_host" : "172.18.0.1",
    "msg_threadId" : 1,
    "level" : 6,
    "msg_endOfBatch" : false,
    "msg_thread" : "main",
    "created" : "2017-08-10T14:40:40.8486884Z",
    "msg_message" : "Mapped \"{[/manage/dump || /manage/dump.json],methods=[GET],produces=[application/vnd.spring-boot.actuator.v1+json || application/json]}\" onto public java.lang.Object org.springframework.boot.actuate.endpoint.mvc.EndpointMvcAdapter.invoke()",
    "msg_level" : "INFO",
    "version" : "1.1",
    "command" : "java -Djava.security.egd=file:/dev/./urandom -Dspring.profiles.active=docker -jar /spring-petclinic.jar",
    "@timestamp" : "2017-08-10T14:40:53.591Z",
    "msg_loggerName" : "org.springframework.boot.actuate.endpoint.mvc.EndpointHandlerMapping",
    "container_name" : "pensive_yalow",
    "image_id" : "sha256:7d5a542e1374d67b2d8a0108ebfa3543ee125cf336f965934e8ad8cf0e2978df",
    "container_id" : "04156ee39f3c665ec88fedcbc112a6550e9b4b018bfbb30f251a77d399881567"
  }
}
```

 