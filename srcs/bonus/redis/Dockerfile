FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    redis \
    procps \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/startup.sh /etc/redis/startup.sh
RUN chmod +x /etc/redis/startup.sh

EXPOSE 6379

ENTRYPOINT [ "/etc/redis/startup.sh" ]

CMD ["redis-server", "--bind", "0.0.0.0", "--port", "6379", "--protected-mode", "no"]


# FROM debian:bullseye-slim

# RUN apt update -y && \
#     apt install -y redis procps && \
#     rm -rf /var/lib/apt/lists/*

# EXPOSE 6379

# ENTRYPOINT [ "/tmp/startup.sh" ]

# CMD ["redis-server", "--bind", "0.0.0.0", "--port", "6379", "--protected-mode", "no"]
