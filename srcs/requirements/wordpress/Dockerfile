# FROM debian:bullseye-slim

# # Sistemi güncelle ve gerekli bağımlılıkları kur
# RUN apt-get update -y && \
#     apt-get install -y \
#     curl \
#     wget \
#     git \
#     unzip \
#     libpng-dev \
#     libjpeg-dev \
#     libfreetype6-dev \
#     mariadb-client \
#     php7.4-fpm \
#     php7.4-mysql \
#     php7.4-gd \
#     php7.4-curl \
#     php7.4-zip \
#     php7.4-opcache \
#     php7.4-mbstring && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*

# # Install wp_cli command and put it in the /usr/local/bin/wp
# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
#     chmod +x wp-cli.phar && \
#     mv wp-cli.phar /usr/local/bin/wp

# # Çalışma dizinini ayarla
# WORKDIR /var/www/html

# # PHP-FPM yapılandırması ve WordPress betiği
# COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
# COPY ./tools/wordpress.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/wordpress.sh

# # PHP-FPM için portu aç
# EXPOSE 9000

# # Giriş noktası ve komut
# ENTRYPOINT [ "wordpress.sh" ]
# CMD [ "php-fpm7.4", "-F" ]



#------------------



    FROM	debian:bullseye

    RUN	apt-get update -y && apt-get upgrade -y && \
        apt-get install -y \
            wget \
            curl \
            bash \
            php7.4 \
            php-cgi \
            php7.4-mysql \
            php7.4-fpm \
            php7.4-pdo \
            php7.4-gd \
            php7.4-cli \
            php7.4-mbstring \
            redis \
            php-redis \
            default-mysql-client
    
    RUN	rm -rf /var/lib/apt/lists/*
    
    # Install wp_cli command and put it in the /usr/local/bin/wp
    RUN	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod +x wp-cli.phar && \
        mv wp-cli.phar /usr/local/bin/wp
    
    # RUN	php-fpm7.4 --version
    
    COPY	./conf/www.conf /etc/php/7.4/fpm/pool.d/
    
    RUN	mkdir /run/php
    
    COPY	./tools/wordpress.sh /usr/local/bin/wordpress.sh
    
    RUN	chmod +x /usr/local/bin/wordpress.sh
    
    ENTRYPOINT	["/usr/local/bin/wordpress.sh"]
    
    RUN	mkdir -p /var/www/html && \
        chmod -R 777 /var/www/html && \
        chown -R www-data:www-data /var/www/html
    
    WORKDIR	/var/www/html/
    
    EXPOSE	9000
    
    # Launch PHP FPM in foreground and ignore daemonize from conf file (-F)
    CMD	["php-fpm7.4", "-F"]
    # CMD	["/usr/sbin/php-fpm7.4", "-F"]