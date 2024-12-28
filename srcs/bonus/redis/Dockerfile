FROM debian:bullseye

RUN apt update -y && \
    apt install -y redis procps && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 6379

CMD ["redis-server", "--bind", "0.0.0.0", "--port", "6379", "--protected-mode", "no"]
