FROM docker.elastic.co/logstash/logstash:5.6.4

RUN plugin install \
    logstash-input-beats \
    logstash-output-amazon_es

RUN apt-get update && apt-get -y install gettext-base && apt-get clean
COPY logstash.conf /config-dir/logstash.tpl.conf
COPY launcher.sh /config-dir/

EXPOSE 5044/tcp

CMD ["/config-dir/launcher.sh"]