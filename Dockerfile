FROM php:8.2-fpm

# Installation des dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    && docker-php-ext-install pdo pdo_mysql

# Installation de Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Installation de Symfony CLI (optionnel, selon ton besoin)
RUN curl -sS https://get.symfony.com/cli/installer | bash -s -- --install-dir=/usr/local/bin \
    && ln -sf /usr/local/bin/symfony /usr/local/bin/symfony-cmd

# Définition du répertoire de travail
WORKDIR /var/www
COPY . .

# Exécution de Composer
RUN composer install --no-dev --optimize-autoloader

# Exposition du port (dynamique via $PORT)
EXPOSE $PORT

# Commande de démarrage avec $PORT
CMD ["sh", "-c", "php -S 0.0.0.0:$PORT public/index.php"]