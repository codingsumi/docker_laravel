# Use the official PHP image as the base image
FROM php:7.4.12-apache

# Install system dependencies
RUN apt-get update && apt-get install libonig-dev && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy existing application directory contents
COPY . /var/www/html

# Change current user to www-data
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80
