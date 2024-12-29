FROM debian:bullseye-slim

# Node.js yükleme
RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Çalışma dizinleri
RUN mkdir -p /var/www/html/static

# Statik dosyaların kopyalanması
COPY ./tools/static_web_pages /static_web_pages
COPY ./tools/startup.sh /usr/local/bin/startup.sh

RUN chmod +x /usr/local/bin/startup.sh

WORKDIR /var/www/html/static

ENTRYPOINT ["/usr/local/bin/startup.sh"]
CMD ["npm", "run", "build"]
