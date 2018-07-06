FROM php:7-apache

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libpq-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql mysqli
	
WORKDIR /var/www/html

VOLUME /var/www/html

EXPOSE 80

ENTRYPOINT ["docker-php-entrypoint", "apache2-foreground"]

