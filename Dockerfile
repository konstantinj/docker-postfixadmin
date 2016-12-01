FROM php:7-alpine
MAINTAINER Konstantin Jakobi <konstantin.jakobi@gmail.com>

ENV VERSION=3.0

EXPOSE 80

RUN apk add --no-cache bash curl dovecot mysql-client c-client imap-dev \
 && docker-php-ext-install imap mysqli \
 && apk del imap-dev \
 && rm -rf /var/cache/apk/* \
 && curl --location https://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-${VERSION}/postfixadmin-${VERSION}.tar.gz | tar xzf - \
 && mv postfixadmin* /www \
 && mkdir /config

COPY config.php php.ini run.sh /
CMD /run.sh
