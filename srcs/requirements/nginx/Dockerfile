FROM debian:bullseye-slim

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl curl procps && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html && \
    chmod -R 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/CN=tkaragoz.42.fr"
    # -subj "/CN=localhost"


COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/startup.sh /usr/local/bin/
#COPY html /usr/share/nginx/html

RUN chmod +x /usr/local/bin/startup.sh

WORKDIR /var/www/html

EXPOSE 443 
#80

ENTRYPOINT ["/usr/local/bin/startup.sh"]
CMD ["nginx", "-g", "daemon off;"]


