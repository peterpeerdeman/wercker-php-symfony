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

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -L https://get.rvm.io | bash -s stable
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN rvm requirements
RUN rvm install 2.0
RUN gem install bundler --no-ri --no-rdoc

WORKDIR /app

CMD ["php"]
