FROM ubuntu:20.04

RUN apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git tasksel imagemagick apache2 make sudo
RUN apt-get install -y php composer php-imagick php-gd
COPY config/vhost.sample.docker /etc/apache2/sites-enabled/000-default.conf

#COPY composer.json /var/www/html
#COPY composer.lock /var/www/html
# RUN composer install

RUN a2enmod rewrite & a2enmod headers

WORKDIR /var/www/html
EXPOSE 8080
CMD ["apachectl", "-D", "FOREGROUND"]
#CMD ["php", "-S", "127.0.0.1:8080", "-t", "web"]