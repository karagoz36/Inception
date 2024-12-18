#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Downloading WordPress..."
    curl -O https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz --strip-components=1 -C /var/www/html
    rm latest.tar.gz

    echo "Configuring WordPress..."
    wp_config="/var/www/html/wp-config.php"
    cp /var/www/html/wp-config-sample.php "$wp_config"
    sed -i "s/database_name_here/${MYSQL_DATABASE}/" "$wp_config"
    sed -i "s/username_here/${MYSQL_USER}/" "$wp_config"
    sed -i "s/password_here/${MYSQL_PASSWORD}/" "$wp_config"
    sed -i "s/localhost/mariadb/" "$wp_config"

    echo "WordPress setup completed!"
fi

echo "Starting PHP-FPM..."
exec "$@"
