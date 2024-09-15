FROM php:8.3-fpm
LABEL authors="Akmal Muhammad Pridianto"

  # Install dependencies
RUN apt-get update && apt-get install -y \
git \
curl \
libpng-dev \
libjpeg62-turbo-dev \
libfreetype6-dev \
libonig-dev \
libxml2-dev \
zip \
unzip \
locales \
&& docker-php-ext-configure gd --with-freetype --with-jpeg \
&& docker-php-ext-install gd intl pdo pdo_mysql mbstring exif pcntl bcmath xml

 # Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
&& mv composer.phar /usr/local/bin/ \
&& ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy source code
# You can add from your ./src folder or from ./ folder
# For this project i will use ./src
COPY ./src .

# Set permission for storage & bootstrap folders
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Optimize Laravel for production
RUN php artisan config:cache && \
php artisan route:cache && \
php artisan view:cache

EXPOSE 9000