FROM php:8.3-apache

LABEL maintainer="Myah Mitchell <code@mitchell.dev>"
ARG Version="4.6.1"

WORKDIR /src

RUN	apt-get update \
	&& apt-get -qqy install wget ssh libldb-dev libldap2-dev bind9utils unzip

RUN wget https://github.com/WillyXJ/facileManager/archive/refs/tags/v$Version-complete.zip \
  && unzip v$Version-complete.zip \
  && mv facileManager-$Version-complete/server/* /var/www/html/ \
	&& chown -R www-data:www-data /var/www/html/

RUN ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
	&& docker-php-ext-install mysqli ldap \
	&& a2enmod rewrite dump_io

COPY config.inc.php /var/www/html/
COPY php.ini /usr/local/etc/php/php.ini

RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/facileManager/
