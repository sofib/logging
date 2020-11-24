FROM alpine:3.12

EXPOSE 514/udp

RUN apk --update add rsyslog && rm -rf /var/cache/apk/*
RUN mkdir /etc/rsyslog.d && mkdir /var/spool/rsyslog

RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf && sed -i '/AbortOnUncleanConfig/s/^#//' /etc/rsyslog.conf

ADD json.template.conf /etc/rsyslog.d/01-json-template.conf
ADD rsyslog.conf /etc/rsyslog.d/02-default.conf

CMD ["rsyslogd", "-n"]