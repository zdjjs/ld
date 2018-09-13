FROM php:7.2-fpm-alpine
WORKDIR /var/www/html

COPY ./php.ini /usr/local/etc/php/
RUN apk update \
&& apk add postgresql-dev libpng-dev libjpeg-turbo-dev icu-dev php7-iconv \
&& apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
&& docker-php-ext-configure intl --enable-intl \
&& docker-php-ext-install pdo_pgsql gd exif intl iconv opcache
