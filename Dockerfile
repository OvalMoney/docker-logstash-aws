FROM docker.elastic.co/logstash/logstash:5.6.4

RUN logstash-plugin remove x-pack && \
    logstash-plugin install logstash-output-amazon_es

USER root
RUN yum update -y && yum install -y gettext && yum clean all

COPY config/logstash.yml config/logstash.yml
COPY pipeline/logstash.conf ./logstash.tpl.conf
RUN chown --recursive logstash:logstash config/ pipeline/

COPY bin/docker-entrypoint /usr/local/bin/
RUN chmod 0755 /usr/local/bin/docker-entrypoint

USER logstash

EXPOSE 5044

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]