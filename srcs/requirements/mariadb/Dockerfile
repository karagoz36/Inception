FROM debian:bullseye-slim

RUN apt-get update -y && apt-get install -y mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 3306

COPY ./tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

ENTRYPOINT [ "/usr/local/bin/startup.sh" ]

CMD	["mysqld", "--bind-address=0.0.0.0"]
