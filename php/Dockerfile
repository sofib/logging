
FROM composer:2.0 AS composer

FROM php:7.4-alpine AS builder

COPY --from=composer /usr/bin/composer /usr/bin/composer

ARG COMPOSER_AUTH='{}'
ENV COMPOSER_AUTH=${COMPOSER_AUTH}

RUN mkdir /app
WORKDIR /app

COPY composer.json /app
RUN composer install

FROM php:7.4-alpine

RUN apk --update add rsyslog && rm -rf /var/cache/apk/*
RUN mkdir /etc/rsyslog.d && mkdir /var/spool/rsyslog
RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf
#COPY rsyslog.conf /etc/rsyslog.conf
COPY rsyslog2.conf /etc/rsyslog.d/default.conf

COPY php.ini /usr/local/etc/php/conf.d/logging.ini

#RUN mkdir /app

COPY --from=builder /app /app
WORKDIR /app
#COPY composer.json /app
#RUN composer install

COPY index.php /app
COPY init.sh /app

# just to keep the container running
#ENTRYPOINT [ "php", "-S", "0.0.0.0:80", "index.php" ]
ENTRYPOINT ["sh", "/app/init.sh" ]
