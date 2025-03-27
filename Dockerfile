FROM php:8.2-fpm

# Installation des dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    && docker-php-ext-install pdo pdo_mysql

# Installation de Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Installation de Symfony CLI (optionnel, pour éviter les erreurs de scripts)
RUN curl -sS https://get.symfony.com/cli/installer | bash -s -- --install-dir=/usr/local/bin \
    && ln -sf /usr/local/bin/symfony /usr/local/bin/symfony-cmd

# Définition du répertoire de travail
WORKDIR /var/www
COPY . .

# Exécution de Composer avec plus de détails
RUN composer install --no-dev --optimize-autoloader --verbose

# Exposition du port
EXPOSE $PORT

# Commande de démarrage avec debug
CMD ["sh", "-c", "echo 'Starting server on port $PORT' && php -S 0.0.0.0:$PORT public/index.php"]