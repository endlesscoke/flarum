FROM php:8.3-fpm-alpine

# Установка системных зависимостей и PHP-расширений для Flarum
RUN apk add --no-cache nginx git unzip libpng-dev libjpeg-turbo-dev freetype-dev icu-dev oniguruma-dev libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql mbstring gd intl zip opcache

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .

# Установка зависимостей из твоего composer.json
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Копирование конфига Nginx
COPY nginx.conf /etc/nginx/http.d/default.conf

# Выдача прав веб-серверу на папку хранилища и ассетов
RUN mkdir -p /app/storage /app/public/assets \
    && chown -R www-data:www-data /app/storage /app/public/assets

EXPOSE 8080

CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]