#!/bin/bash

mkdir -p /var/run/vsftpd/empty /var/www/html

mv /tmp/vsftpd.conf /etc/vsftpd.conf

adduser --disabled-password --gecos "" "$FTP_USER"
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

chown -R "$FTP_USER:$FTP_USER" /var/www/html
chmod 755 /var/www/html

echo "$FTP_USER" | tee -a /etc/vsftpd.userlist > /dev/null

exec "$@"