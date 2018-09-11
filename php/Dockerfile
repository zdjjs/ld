FROM php:7-fpm-alpine
WORKDIR /var/www/html

RUN apk update
RUN apk add postgresql-dev
RUN docker-php-ext-install pdo pdo_pgsql mbstring
