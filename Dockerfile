FROM ubuntu:17.04

MAINTAINER Andrés Nacimiento <andresnacimiento@gmail.com>

RUN apt-get update
RUN apt-get install -y apache2 \
	curl \
	php \
	libapache2-mod-php \
	php-mcrypt \
	unzip \
	php-mysql \
	wget \
	php7.0-xml \
	php7.0-gd \
	php7.0-mbstring

# Get PrestaShop
ADD https://www.prestashop.com/download/old/prestashop_1.6.1.12.zip /tmp/prestashop.zip
RUN unzip /tmp/prestashop.zip -d /var/www/html/
RUN rm /tmp/prestashop.zip

# Apache configuration
# Fuente: https://github.com/paulczar/docker-apache2/blob/master/Dockerfile
env APACHE_RUN_USER    www-data
env APACHE_RUN_GROUP   www-data
env APACHE_PID_FILE    /var/run/apache2.pid
env APACHE_RUN_DIR     /var/run/apache2
env APACHE_LOCK_DIR    /var/lock/apache2
env APACHE_LOG_DIR     /var/log/apache2
env LANG C
CMD ["apache2", "-D", "FOREGROUND"]

RUN a2enmod rewrite
COPY config_files/defines.inc.php /var/www/html/prestashop/config/
RUN chown www-data:www-data -R /var/www/html/
RUN chmod 777 -R /var/www/html/


# PHP configuration
COPY config_files/php.ini /usr/local/etc/php/
