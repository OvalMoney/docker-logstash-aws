FROM jruby:9-alpine as build-plugin-aws-es
ENV LOGSTASH_AWS_ES_VERSION be664634ee36d01351970dd212508fbcbd4fbaf4

RUN wget -O plugin.zip https://github.com/awslabs/logstash-output-amazon_es/archive/${LOGSTASH_AWS_ES_VERSION}.zip && \
  unzip plugin.zip

WORKDIR /logstash-output-amazon_es-${LOGSTASH_AWS_ES_VERSION}

RUN gem build logstash-output-amazon_es.gemspec  && \
    mv logstash-output-amazon_es*.gem ..


FROM docker.elastic.co/logstash/logstash-oss:6.5.1 as run

COPY --from=build-plugin-aws-es logstash-output-amazon_es*.gem .
RUN bin/logstash-plugin install logstash-output-amazon_es*.gem && \
    rm -rf vendor/cache/* && rm -rf vendor/bundle/jruby/2.3.0/cache/* 

USER root

COPY config/logstash.yml config/logstash.yml
COPY pipeline/logstash.conf pipeline/logstash.conf

RUN chown --recursive logstash:logstash config/ pipeline/
USER logstash

EXPOSE 5044
