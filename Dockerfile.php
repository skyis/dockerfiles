FROM php:5.5-fpm

# Install modules
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        git \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd opcache pdo pdo_mysql mbstring

RUN mkdir -p /var/log/app/
RUN touch /var/log/app/application.log
RUN chmod 666 /var/log/app/application.log

COPY ./etc/php-fpm.conf /usr/local/etc/
COPY ./etc/php.ini /usr/local/etc/php/

CMD ["php-fpm"]
