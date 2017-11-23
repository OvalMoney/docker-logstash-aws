FROM docker.elastic.co/logstash/logstash:5.6.4

USER root
RUN yum update -y && yum install -y gettext && yum clean all

USER logstash
RUN logstash-plugin remove \
    x-pack \
    && \
    logstash-plugin install \
    logstash-input-beats \
    logstash-output-amazon_es

COPY --chown=logstash:logstash logstash.conf ./logstash.tpl.conf
COPY  --chown=logstash:logstash launcher.sh ./launcher.sh

EXPOSE 5044/tcp

ENTRYPOINT []

CMD ["./launcher.sh"]