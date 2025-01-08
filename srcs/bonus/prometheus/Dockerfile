FROM debian:bullseye

ARG PROMETHEUS_VERSION=2.45.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates procps && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Download and Install Prometheus
RUN wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz \
    && tar xfz prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz \
    && mkdir -p /etc/prometheus \
    && mv prometheus-${PROMETHEUS_VERSION}.linux-amd64/prometheus /usr/local/bin/ \
    && mv prometheus-${PROMETHEUS_VERSION}.linux-amd64/promtool /usr/local/bin/ \
    && mv prometheus-${PROMETHEUS_VERSION}.linux-amd64/consoles /etc/prometheus/ \
    && mv prometheus-${PROMETHEUS_VERSION}.linux-amd64/console_libraries /etc/prometheus/ \
    && rm -rf /tmp/*

COPY conf/prometheus.yml /etc/prometheus/prometheus.yml

EXPOSE 9090

ENTRYPOINT ["/usr/local/bin/prometheus"]
CMD ["--config.file=/etc/prometheus/prometheus.yml", \
     "--storage.tsdb.path=/tmp/prometheus"]
