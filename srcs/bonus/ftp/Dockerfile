FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y vsftpd && \
    rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /tmp/vsftpd.conf

COPY tools/startup.sh /tmp/startup.sh
RUN chmod +x /tmp/startup.sh

EXPOSE 21 20000-20100

ENTRYPOINT ["/tmp/startup.sh"]
CMD ["vsftpd", "/etc/vsftpd.conf"]