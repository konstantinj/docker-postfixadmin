FROM php:7-alpine
ENV VERSION=3.1
EXPOSE 8000
RUN apk add --no-cache bash curl dovecot mysql-client c-client imap-dev su-exec \
 && docker-php-ext-install imap mysqli \
 && apk del imap-dev \
 && rm -rf /var/cache/apk/* \
 && curl --location https://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-${VERSION}/postfixadmin-${VERSION}.tar.gz \
    | tar xzf - --no-same-owner --one-top-level=/www --strip=1 \
 && mkdir /config
COPY config.php php.ini run.sh /
CMD ["/run.sh"]
