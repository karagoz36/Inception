FROM debian:bullseye

# Gerekli paketlerin kurulumu
RUN apt-get update && \
    apt-get install -y vsftpd && \
    rm -rf /var/lib/apt/lists/*

# vsftpd yapılandırma dosyasını kopyalama
COPY conf/vsftpd.conf /tmp/vsftpd.conf

# Başlangıç betiğini kopyalama
COPY tools/startup.sh /tmp/startup.sh
RUN chmod +x /tmp/startup.sh

# FTP portlarını açma
EXPOSE 21 20000-20100

# Başlangıç komutu
ENTRYPOINT ["/tmp/startup.sh"]
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
