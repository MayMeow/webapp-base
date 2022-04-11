FROM php:8.0.17-fpm-buster

# arguments in docker-compose file
ARG user=webapp
ARG uid=20021

# Install Libraries
RUN apt-get update \
    && apt-get install --fix-missing -y unzip libicu-dev libpq-dev zlib1g-dev libpng-dev libzip-dev netcat

# Install PHP Extensions
RUN docker-php-ext-install intl pdo_pgsql gd zip pdo_mysql

# PHP Pecl Redis extensions
RUN pecl install redis
RUN docker-php-ext-enable redis

# Clean
RUN apt autoremove --purge -y \
    && apt clean
    
# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user
    
