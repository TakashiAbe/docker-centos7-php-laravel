#!/bin/bash

set -e

if [ ! -e /var/www/laravel ]; then
  mv /var/www_tmp/laravel /var/www
  rm -rf /var/www_tmp
  cd /var/www && ln -s /var/www/laravel/public html
  chmod -R a+w /var/www/laravel/storage/
  chmod -R a+w /var/www/laravel/bootstrap/cache/
  sed -i -e "s/'DB_HOST', 'localhost'/'DB_HOST', '${MYSQL_PORT_3306_TCP_ADDR}'/g" /var/www/laravel/config/database.php
  sed -i -e "s/'DB_PORT', '3306'/'DB_PORT', '${MYSQL_PORT_3306_TCP_PORT}'/g" /var/www/laravel/config/database.php
  sed -i -e "s/'DB_DATABASE', 'forge'/'DB_DATABASE', '${MYSQL_ENV_MYSQL_DATABASE}'/g" /var/www/laravel/config/database.php
  sed -i -e "s/'DB_USERNAME', 'forge'/'DB_USERNAME', '${MYSQL_ENV_MYSQL_USER}'/g" /var/www/laravel/config/database.php
  sed -i -e "s/'DB_PASSWORD', ''/'DB_PASSWORD', '${MYSQL_ENV_MYSQL_ROOT_PASSWORD}'/g" /var/www/laravel/config/database.php
  sed -i -e "s/'charset' => 'utf8'/'charset' => 'utf8mb4'/g" /var/www/laravel/config/database.php
  sed -i -e “s/'en'/'ja'/g” /var/www/laravel/config/app/php
fi

if [ -e /var/www/html ]; then
  umount /var/www/html
  rm -rf /var/www/html
  cd /var/www && ln -s /var/www/laravel/public html
  chmod -R a+w /var/www/laravel/bootstrap/cache
fi

exec "$@"