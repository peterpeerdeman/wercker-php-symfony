FROM php:5.6

# Install git
RUN apt-get update && apt-get install -y \
        git \
        zlib1g-dev \
    && docker-php-ext-install \
	zip \
	mbstring \
	pdo_mysql

COPY php.ini.dist /usr/local/etc/php/php.ini

CMD ["php"]
