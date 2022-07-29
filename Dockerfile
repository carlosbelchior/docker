FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
        libicu-dev \
    && docker-php-ext-install \
        intl \
        opcache \
    && docker-php-ext-enable \
        intl \
        opcache \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-install mysqli

RUN apt-get install -y zip unzip zlib1g-dev libpng-dev libzip-dev
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd

RUN curl -sS https://getcomposer.org/installer | php

RUN mv composer.phar /usr/local/bin/composer

USER root

# Configure non-root user.
ARG PUID=1000
ARG PGID=1000

RUN groupmod -o -g ${PGID} html-data && \
    usermod -o -u ${PUID} -g html-data html-data

WORKDIR /var/www/html