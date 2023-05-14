FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
        libicu-dev \
    && docker-php-ext-install \
        intl \
        opcache \
    && docker-php-ext-enable \
        intl \
        opcache

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    nano

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN git config --global user.email "hi@hi.local" \
    && git config --global user.name "hi" \
    && curl -sS https://get.symfony.com/cli/installer | bash \
    && symfony new app --version="6.2.*" --webapp

ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0"
ADD opcache.ini "/usr/local/etc/php/conf.d/opcache.ini"

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini && \
    sed -i 's/short_open_tag=Off' /usr/local/etc/php/php.ini

EXPOSE 9000
CMD ["php-fpm"]
