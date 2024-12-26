FROM debian:bullseye

# Install only necessary packages
RUN apt-get update -y && apt-get install -y \
		wget \
		curl \
		php7.4 \
		php7.4-mysql \
		php7.4-fpm \
		default-mysql-client && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# Install wp-cli command
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Copy PHP-FPM configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# Copy startup script
COPY ./tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# Set working directory and permissions
RUN mkdir -p /var/www/html && \
	chmod -R 755 /var/www/html && \
	chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html/

# Expose PHP-FPM port
EXPOSE 9000

# Use startup script as entry point
ENTRYPOINT ["/usr/local/bin/startup.sh"]

# Run PHP-FPM in the foreground
CMD ["php-fpm7.4", "-F"]
