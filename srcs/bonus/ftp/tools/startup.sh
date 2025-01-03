#!/bin/bash

# if [ ! -f "/etc/vsftpd.conf" ]; then

    echo "Initializing vsftpd configuration..."

    # Güvenli chroot dizini oluşturma
    mkdir -p /var/run/vsftpd/empty
    mkdir -p /var/www/html
    mv /tmp/vsftpd.conf /etc/vsftpd.conf


    # vsftpd yapılandırma dosyasını yedekleme ve yeni yapılandırmayı uygulama
    mv /tmp/vsftpd.conf /etc/vsftpd.conf

    # FTP kullanıcısını oluşturma ve parola ayarlama
    adduser --disabled-password --gecos "" "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

    # /home/$FTP_USER dizininin sahipliğini ve izinlerini ayarlama
    chown -R "$FTP_USER:$FTP_USER" /var/www/html
    chmod 755 /var/www/html

    # FTP kullanıcısını vsftpd kullanıcı listesine ekleme
    echo "$FTP_USER" | tee -a /etc/vsftpd.userlist > /dev/null

# fi

echo "FTP server starting on port 21 and passive ports 20000-20100..."

exec "$@"
