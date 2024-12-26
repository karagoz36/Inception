#!/bin/bash

if [ ! -f ./wp-config.php ]; then
	
	## for debugging
	echo "Downloading WordPress..."
	# Download WordPress and all config files
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	## for debugging
	echo "Configuring wp-config.php with environment variables..."
	# Import env variables in the config file
	cp wp-config-sample.php wp-config.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
	sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config.php
	sed -i "s/localhost/$WORDPRESS_DB_HOST/g" wp-config.php

	## for debugging
	echo "WordPress setup completed."

fi

# Wait until MariaDB is ready
echo "Waiting for the database to be ready..."
until wp db check --allow-root; do
	echo "Waiting for database connection..."
	sleep 3
done

# Install WordPress core
wp core install --url="${WP_SITE_URL}" --title="${WP_SITE_TITLE}" \
	--admin_user="${WP_ADMIN_USERNAME}" --admin_password="${WP_ADMIN_PASSWORD}" \
	--admin_email="${WP_ADMIN_EMAIL}" --skip-email --allow-root

# Set permissions
chmod -R 777 ./wp-content
chown -R www-data:www-data ./wp-content

exec "$@"
