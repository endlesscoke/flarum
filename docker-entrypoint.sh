#!/bin/sh
set -e

chown -R www-data:www-data /app

# If config.php exists and MYSQLHOST is set, check if Flarum tables exist.
# When the database is empty, move config.php aside so Flarum shows the installer instead of 500.
if [ -f /app/config.php ] && [ -n "$MYSQLHOST" ]; then
  HAS_TABLES=$(php -r '
    try {
      $port = getenv("MYSQLPORT") ?: "3306";
      $dsn = "mysql:host=" . getenv("MYSQLHOST") . ";port=" . $port . ";dbname=" . getenv("MYSQLDATABASE");
      $pdo = new PDO($dsn, getenv("MYSQLUSER"), getenv("MYSQLPASSWORD"), [PDO::ATTR_TIMEOUT => 5]);
      $stmt = $pdo->query("SHOW TABLES LIKE '\''settings'\''");
      echo ($stmt && $stmt->rowCount() > 0) ? "1" : "0";
    } catch (Throwable $e) {
      echo "err";
    }
  ')
  if [ "$HAS_TABLES" = "0" ]; then
    mv /app/config.php /app/config.php.bak
  fi
fi

php-fpm -D
exec nginx -g 'daemon off;'
