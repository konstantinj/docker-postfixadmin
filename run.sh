#!/bin/bash

wait_for_mysql() {
  until mysql --host=$MYSQL_HOST --user=$MYSQL_USER --password=$MYSQL_PASSWORD --execute="USE $MYSQL_DATABASE;" &>/dev/null; do
    echo "waiting for mysql to start..."
    sleep 2
  done
}

wait_for_php() {
  until curl --output /dev/null --silent --get --fail "http://localhost"; do
    echo "waiting for php to start..."
    sleep 2
  done
}

init_config() {
  cat config.php>/www/config.local.php
  echo "<?php">/config/__config.php
  for e in $(env); do
    case $e in
      PA_*)
        e1=$(expr "$e" : 'PA_\([A-Z_]*\)')
        e2=$(expr "$e" : '\([A-Z_]*\)')
        echo "\$CONF['${e1,,}'] = getenv('$e2');">>/config/__config.php
    esac
  done
}

init_db() {
  php -S 127.0.0.1:80 -c php.ini -t /www &
  wait_for_php
  pid_php=$!
  setup_password="s3cr3t";
  salt=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)
  password_hash=$(echo -n "$salt:$setup_password" | sha1sum | cut -d ' ' -f 1)
  setup_password_hash="$salt:$password_hash"
  echo "<?php \$CONF['setup_password'] = '$setup_password_hash';">/config/___setup_password.php
  curl --silent  --output /dev/null --data "form=createadmin&setup_password=$setup_password&username=$ADMIN_USERNAME&password=$ADMIN_PASSWORD&password2=$ADMIN_PASSWORD" http://localhost/setup.php
  kill $pid_php
  wait $pid_php 2>/dev/null
  rm -rf /www/setup.php /config/___setup_password.php
}

wait_for_mysql
init_config

mkdir -p /www/templates_c
chown -R www-data:www-data /www/templates_c

if [ ! -f .initialized ]; then
  init_db
  touch .initialized
fi


trap 'kill -9 $(jobs -p)' EXIT
trap 'exit' INT TERM

su-exec nobody php -S 0.0.0.0:8000 -c /php.ini -t /www &

wait
