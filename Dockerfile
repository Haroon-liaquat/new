FROM php:7.4-apache

ENV COMPOSER_ALLOW_SUPERUSER=1

COPY --from=composer /usr/bin/composer /usr/bin/composer
WORKDIR "/var/www/html"

COPY  composer.json /var/www/html/

RUN  apt-get update && apt-get install -y zip unzip git libpng-dev

RUN docker-php-ext-install gd

RUN docker-php-ext-install pdo pdo_mysql mysqli

COPY --from=composer /usr/bin/composer /usr/bin/composer

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y git
RUN apt-get install -y curl 
RUN apt-get install -y     libpng-dev 
RUN apt-get install -y     libonig-dev 
RUN apt-get install -y     libxml2-dev 
RUN apt-get install -y     zip 
RUN apt-get install -y     unzip 
RUN apt-get install -y    nano
RUN apt-get install -y    nfs-client 
RUN apt-get install -y    vim
RUN apt-get install -y    libfreetype6-dev 
RUN apt-get install -y    net-tools 
RUN apt-get install -y    wget 
RUN apt-get install -y    libjpeg62-turbo-dev 
RUN apt-get install -y    libpng-dev 
RUN docker-php-ext-configure gd --with-freetype --with-jpeg 
RUN docker-php-ext-install -j$(nproc) gd gettext mysqli pdo_mysql
# RUN      mount -v -o vers=4,loud 192.168.0.4:/ /mnt 
RUN      touch /mnt/file.txt 
RUN     wget https://github.com/ContainX/docker-volume-netshare/releases/download/v0.36/docker-volume-netshare_0.36_amd64.deb
RUN     dpkg -i docker-volume-netshare_0.36_amd64.deb
RUN     service docker-volume-netshare start

RUN a2enmod rewrite

COPY saarey /var/www/html/
USER root
EXPOSE 80/tcp
EXPOSE 443/tcp
