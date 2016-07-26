FROM php:5.6
MAINTAINER Peter Peerdeman <peter@lifely.nl>
# Install packages
RUN apt-get update && apt-get install -y \
        git \
	libpng12-dev \
        zlib1g-dev \
    && docker-php-ext-install \
	gd \
	mbstring \
	opcache \
	pdo_mysql \
	zip \
    pcntl

COPY php.ini.dist /usr/local/etc/php/php.ini

WORKDIR /tmp

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer require "phpunit/phpunit:~5.4.7" --prefer-source --no-interaction
RUN composer require "phpunit/php-invoker" --prefer-source --no-interaction
RUN ln -s /tmp/vendor/bin/phpunit /usr/local/bin/phpunit

RUN apt-get -y install python-software-properties git build-essential
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

WORKDIR /app

CMD ["php"]
