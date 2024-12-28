#!/bin/bash

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h"${MYSQL_HOSTNAME}" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --silent; do
    sleep 3
done

# Check if WordPress is already configured
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Configuring WordPress..."

    # Set up WordPress configuration
    wp core config \
        --allow-root \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="${MYSQL_HOSTNAME}"

    # Install WordPress
    wp core install \
        --allow-root \
        --url="${WP_SITE_URL}" \
        --title="${WP_SITE_TITLE}" \
        --admin_user="${WP_ADMIN_USERNAME}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}"

    # Add a regular user
    wp user create \
        --allow-root \
        "${WP_USER_USERNAME}" "${WP_USER_EMAIL}" \
        --role=editor \
        --user_pass="${WP_USER_PASSWORD}"

	wp theme install twentytwentytwo --activate --allow-root --path=/var/www/html

fi

chown -R www-data:www-data ./wp-content
chmod -R 755 ./wp-content

# Start PHP-FPM
echo "Starting PHP-FPM..."
exec "$@"
