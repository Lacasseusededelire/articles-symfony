FROM php:8.2-fpm

# Installation des dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    && docker-php-ext-install pdo pdo_mysql

# Installation de Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Définition du répertoire de travail
WORKDIR /var/www
COPY . .

# Exécution de Composer
RUN composer install --no-dev --optimize-autoloader

# Exposition du port (Render utilise $PORT, mais ici un exemple)
EXPOSE 8000

# Commande de démarrage
CMD ["php", "-S", "0.0.0.0:8000", "public/index.php"]