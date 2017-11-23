#!/bin/bash

# Replace the environment variables with the proper values
envsubst < ./logstash.tpl.conf > ./logstash.conf

# Execute logstash and get PID 1
exec logstash -f ./logstash.conf