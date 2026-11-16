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

# Копирование конфига Nginx и отключение очистки env в PHP-FPM
COPY nginx.conf /etc/nginx/http.d/default.conf
RUN echo "clear_env = no" >> /usr/local/etc/php-fpm.d/zz-docker.conf

# Создание нужных папок и выдача прав на весь корень /app
RUN mkdir -p /app/storage /app/public/assets \
    && chown -R www-data:www-data /app \
    && chmod -R 775 /app/storage /app/public/assets

EXPOSE 8080

# Обновляем права при каждом запуске контейнера (на случай монтирования Volume) и запускаем сервисы
CMD ["sh", "-c", "chown -R www-data:www-data /app && php-fpm -D && nginx -g 'daemon off;'"]