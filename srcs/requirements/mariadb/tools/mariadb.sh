#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initializing MariaDB..."
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld_safe --datadir=/var/lib/mysql &

until mysqladmin ping -uroot -p"${MYSQL_ROOT_PASSWORD}" --silent; do
	echo "Waiting for MariaDB..."
	sleep 5
done

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
	echo "Setting up MariaDB..."
	mysql -uroot <<END
	-- Set root password and disable remote root login
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
	DELETE FROM mysql.user WHERE User=''; -- Remove anonymous users
	DROP DATABASE IF EXISTS test; -- Remove test database
	FLUSH PRIVILEGES;

	-- Allow root to connect from any host
	GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;

	-- Create initial database and user with privileges
	CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
	CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
	GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
	FLUSH PRIVILEGES;
END

	if [ -f /usr/local/bin/wordpress.sql ]; then
	mysql -uroot -p"${MYSQL_ROOT PASSWORD}" ${MYSQL_DATABASE} < /usr/local/bin/wordpress.sql
	fi
fi

mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

exec "$@"



# ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;
# CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
# CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
# GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
# FLUSH PRIVILEGES;