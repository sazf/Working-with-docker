FROM php:8.2-apache

RUN apt-get update && \
    apt-get install -y libzip-dev && \
    docker-php-ext-install zip pdo_mysql

WORKDIR /var/www/html

RUN a2enmod rewrite
# RUN sed -i 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf
EXPOSE 80