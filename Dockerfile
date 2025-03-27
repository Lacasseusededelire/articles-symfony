FROM php:8.2-fpm
RUN apt-get update && apt-get install -y libpq-dev
RUN docker-php-ext-install pdo pdo_mysql
WORKDIR /var/www
COPY . .
RUN composer install --no-dev --optimize-autoloader
EXPOSE 8000
CMD ["php", "-S", "0.0.0.0:8000", "public/index.php"]