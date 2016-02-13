# PostfixAdmin Docker image

[![](https://badge.imagelayers.io/konjak/postfixadmin:latest.svg)](https://imagelayers.io/?images=konjak/postfixadmin:latest)

Production ready Docker container for [PostfixAdmin](http://postfixadmin.sourceforge.net/) with MySQL usage.

## Features - why using this image instead of several others?

- Uses [alpine](https://registry.hub.docker.com/_/alpine/) base image
- This image is as small as possible - uses PHP built-in webserver
- Uses linked MySQL DB
- Waits for MySQL container to be ready before initializing postfixadmin DB
- It's possible to completely change postfixadmin's configuration
- Installs latest stable postfixadmin release

## Usage

```bash
sudo docker run \
  -p 80:80 \
  -v ./folder-with-php-config-files:/config \
  -e MYSQL_HOST=db \
  -e MYSQL_USER=postfix \
  -e MYSQL_PASSWORD=password \
  -e MYSQL_DATABASE=postfix \
  -e USERNAME=user@mail.tld - username is actually an email address to login to postfixadmin - THE admin account \
  -e PASSWORD=password - password for the admin account - must contain AT LEAST two digits \
  -e PA_DOMAIN_PATH=YES \ 
  konjak/postfixadmin
```

All provided env vars starting with PA\_ will be converted to config values for postfixadmin.

It's also possible to mount a folder with php config files to `/config`. All \*.php files in this folder will be executed after the base config.

## Status

Production stable.
