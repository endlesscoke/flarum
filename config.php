<?php return [
  'debug' => false,
  'database' => [
    'driver' => 'mysql',
    'host' => getenv('MYSQLHOST'),
    'port' => getenv('MYSQLPORT') ?: 3306,
    'database' => getenv('MYSQLDATABASE'),
    'username' => getenv('MYSQLUSER'),
    'password' => getenv('MYSQLPASSWORD'),
    'charset' => 'utf8mb4',
    'collation' => 'utf8mb4_unicode_ci',
    'prefix' => '',
    'strict' => false,
    'engine' => 'InnoDB',
    'prefix_indexes' => true,
  ],
  'url' => 'https://flarum-production-ceed80f6.up.railway.app',
  'paths' => [
    'api' => 'api',
    'admin' => 'admin',
  ],
  'headers' => [
    'poweredByHeader' => false,
    'referrerPolicy' => 'same-origin',
  ],
];