# Docker Logstash Filebeat In / AWS ES  Out
Logstash collector with Filebeat input plugin and AWS ES output plugin


## Configuration
Default pipeline config accept these env vars

| ENV           | Default       | Required |
| ------------- | ------------- | -------- |
| FB_HOST       | 127.0.0.1     | YES      |
| FB_PORT       | 5044          | YES      |
| ES_HOST       |               | YES      |
| AWS_REGION    |               | YES      |
| ACCESS_KEY    |               | NO       |
| SECRET_KEY    |               | NO       |
| INDEX_PREFIX  | logstash      | NO       |


```
input { 
  beats {
    host => "${FB_HOST:127.0.0.1}"
    port => "${FB_PORT:5044}"
  }
}

output {
    amazon_es {
        hosts => ["${ES_HOST}"]
        region => "${AWS_REGION}"
        aws_access_key_id => "${ACCESS_KEY:}"
        aws_secret_access_key => "${SECRET_KEY:}"
        index => "${INDEX_PREFIX:logstash}-%{+YYYY.MM.dd}"
    }
}
```

To use a different config just mount it on `/usr/share/logstash/pipeline/logstash.conf`