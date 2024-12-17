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


COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./html/index.html /var/www/html/


WORKDIR /var/www/html

EXPOSE 443 

CMD ["nginx", "-g", "daemon off;"]


