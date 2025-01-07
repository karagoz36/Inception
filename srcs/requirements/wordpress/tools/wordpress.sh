#!/bin/bash

MYSQL_PASSWORD=$(cat /run/secrets/mysql_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/mysql_root_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h"${MYSQL_HOSTNAME}" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --silent; do
    sleep 3
done

wp core download --allow-root

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

# WordPress Redis Configuration
wp config set WP_CACHE true --raw --allow-root
wp config set WP_DEBUG true --raw --allow-root
wp config set WP_DEBUG_LOG true --raw --allow-root
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root

#Activate Redis
if ! wp plugin is-installed redis-cache --allow-root; then
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root
fi

chown -R www-data:www-data ./wp-content
chmod -R 755 ./wp-content

# Start PHP-FPM
echo "Starting PHP-FPM..."
exec "$@"
