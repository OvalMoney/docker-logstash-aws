input { 
  beats {
    port => 5044
  }
}

output {
    amazon_es {
        hosts => ["$ES_HOST"]
        region => "$AWS_REGION"
        aws_access_key_id => '$ACCESS_KEY'
        aws_secret_access_key => '$SECRET_KEY'
        index => "$ENVIRONMENT-logs-%{+YYYY.MM.dd}"
    }
}