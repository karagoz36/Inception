#FROM debian:buster

# 1. Debian tabanlı NGINX imajını temel alıyoruz
FROM nginx:stable

# 2. HTML dosyalarını ve NGINX yapılandırmasını kopyalıyoruz

COPY nginx-ssl /etc/nginx/ssl
COPY html /usr/share/nginx/html
COPY conf/default.conf /etc/nginx/conf.d/

# 3. NGINX çalıştırma komutu
CMD ["nginx", "-g", "daemon off;"]
