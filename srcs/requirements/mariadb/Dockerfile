FROM debian:bullseye-slim

RUN apt-get update -y && apt-get install -y mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN	mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

EXPOSE 3306

COPY ./tools/mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]

CMD	["mysqld", "--bind-address=0.0.0.0"]
