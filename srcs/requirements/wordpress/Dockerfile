FROM debian:bullseye-slim

# Install required packages
RUN apt-get update -y && apt-get install -y \
    php php-fpm php-mysql wget curl unzip mariadb-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Redis PHP
RUN apt-get update && apt-get install -y \
    redis \
    php-redis && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create necessary directories and set permissions
RUN mkdir -p /run/php && \
    chmod -R 755 /run/php

# Download and set up WordPress
WORKDIR /var/www/html

# Copy configuration files
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/wordpress.sh /usr/local/bin/wordpress.sh

# Make wordpress script executable
RUN chmod +x /usr/local/bin/wordpress.sh

RUN	chmod -R 777 /var/www/html && \
	chown -R www-data:www-data /var/www/html

# Expose the PHP-FPM port
EXPOSE 9000

# Start PHP-FPM via the wordpress script
ENTRYPOINT [ "/usr/local/bin/wordpress.sh" ]

CMD ["php-fpm7.4", "-F"]
