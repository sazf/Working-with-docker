FROM composer 

WORKDIR /app
COPY composer.json /app/
RUN composer install --ignore-platform-reqs --no-ansi --no-dev --no-interaction --no-scripts 

COPY . /app/

RUN composer dump-autoload --optimize --no-dev --classmap-authoritative 

FROM php:8.2-apache

LABEL maintainer="sazf@hotmail.com"
LABEL application="Test de PHP 8.2"

# RUN apt-get update 
# RUN apt-get install -y --no-install-recommends git zip
# RUN curl --silent --show-error https://getcomposer.org/installer | php

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN docker-php-ext-install pdo_mysql 

ENV PHP_DISPLAY_ERRORS="On"

WORKDIR /app

COPY --from=0 /app /var/www/html
COPY php.ini /usr/local/etc/php/
# COPY . /var/www/html


# RUN composer install --ignore-platform-reqs --no-ansi --no-dev --no-interaction --no-scripts 