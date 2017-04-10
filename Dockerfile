FROM ubuntu:zesty

MAINTAINER Andrés Nacimiento <andresnacimiento@gmail.com>

RUN apt-get update
RUN apt-get install -y apache2 && apt-get install -y curl && apt-get install -y php && apt-get install -y libapache2-mod-php && apt-get install -y php-mcrypt && apt-get install -y unzip
# mysql-server php-mysql phpmyadmin

# Get PrestaShop
ADD https://www.prestashop.com/download/old/prestashop_1.6.1.12.zip /tmp/prestashop.zip
RUN unzip /tmp/prestashop.zip -d /var/www/html/
RUN rm /tmp/prestashop.zip

# Apache configuration
RUN a2enmod rewrite
RUN chown www-data:www-data -R /var/www/html/
RUN chmod 755 -R /var/www/html/

# PHP configuration
COPY config_files/php.ini /usr/local/etc/php/
