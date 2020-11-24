FROM alpine:3.8

EXPOSE 514/udp

RUN apk --update add syslog-ng && rm -rf /var/cache/apk/*

COPY syslog-ng.conf /etc/syslog-ng/conf.d/php-box.conf

RUN ls -la /etc/syslog-ng/

CMD ["syslog-ng"]