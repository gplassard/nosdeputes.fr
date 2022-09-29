FROM ubuntu:20.04

RUN apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git tasksel imagemagick apache2 make sudo php composer php-imagick php-gd php-mysql
COPY config/vhost.sample.docker /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod rewrite & a2enmod headers

WORKDIR /var/www/html
EXPOSE 8080
CMD ["apachectl", "-D", "FOREGROUND"]