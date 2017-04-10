FROM php:5.6-apache

MAINTAINER Andrés Nacimiento <andresnacimiento@gmail.com>

RUN apt-get update 
RUN apt-get install -y libmcrypt-dev libjpeg62-turbo-dev libpng12-dev libfreetype6-dev libxml2-dev libicu-dev mysql-client wget unzip phpmyadmin
RUN rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
RUN docker-php-ext-install iconv intl mcrypt pdo pdo_mysql mbstring soap gd zip

RUN docker-php-source extract \
	&& if [ -d "/usr/src/php/ext/mysql" ]; 
			then docker-php-ext-install mysql;
		fi \
	&& if [ -d "/usr/src/php/ext/opcache" ]; 
			then docker-php-ext-install opcache; 
		fi \
	&& docker-php-source delete

ENV PS_VERSION 1.6.1.12

# Get PrestaShop
ADD https://www.prestashop.com/download/old/prestashop_1.6.1.12.zip /tmp/prestashop.zip
COPY config_files/ps-extractor.sh /tmp/
RUN mkdir /tmp/data-ps && unzip -q /tmp/prestashop.zip -d /tmp/data-ps/ && bash /tmp/ps-extractor.sh /tmp/data-ps && rm /tmp/prestashop.zip
COPY config_files/docker_updt_ps_domains.php /var/www/html/

# Apache configuration
RUN a2enmod rewrite
RUN chown www-data:www-data -R /var/www/html/
RUN chmod 755 -R /var/www/html/

# PHP configuration
COPY config_files/php.ini /usr/local/etc/php/

VOLUME /var/www/html/modules
VOLUME /var/www/html/themes
VOLUME /var/www/html/override

COPY config_files/docker_run.sh /tmp/
CMD ["/tmp/docker_run.sh"]
