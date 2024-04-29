FROM php:8.2-apache

LABEL maintainer="Myah Mitchell <code@mitchell.dev>"
ARG Version=latest

WORKDIR /src

RUN	apt-get update \
	&& apt-get -qqy install wget libldb-dev libldap2-dev bind9utils \
	&& wget http://www.facilemanager.com/download/facilemanager-complete-$Version.tar.gz \
	&& tar -xvf facilemanager-complete-$Version.tar.gz \
	&& mv facileManager/server/* /var/www/html/ \
	&& chown -R www-data:www-data /var/www/html/

RUN ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
	&& docker-php-ext-install mysqli ldap \
	&& a2enmod rewrite dump_io

COPY config.inc.php /var/www/html/
COPY php.ini /usr/local/etc/php/php.ini
#COPY init.php.patch /var/www/html/fm-includes/

#RUN patch /var/www/html/fm-includes/init.php /var/www/html/fm-includes/init.php.patch

RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/facileManager/
