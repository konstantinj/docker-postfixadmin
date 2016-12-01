FROM alpine
MAINTAINER Konstantin Jakobi <konstantin.jakobi@gmail.com>

ENV VERSION=3.0

EXPOSE 80

RUN apk add --no-cache bash curl dovecot mysql-client php-imap php-mysqli \
 && curl --location https://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-${VERSION}/postfixadmin-${VERSION}.tar.gz | tar xzf - \
 && mv postfixadmin* /www \
 && mkdir /config

COPY config.php php.ini run.sh /
CMD /run.sh
