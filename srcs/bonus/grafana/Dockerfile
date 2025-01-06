FROM debian:bullseye-slim

ARG DEBIAN_FRONTEND=noninteractive

# 1) Sistemi güncelleyin ve gerekli bağımlılıkları kurun
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gnupg \
        wget \
        ca-certificates \
        apt-transport-https \
        procps \
        software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# 2) Grafana GPG anahtarını ekleyin ve depo ekleyin
RUN wget -q -O /usr/share/keyrings/grafana.key https://packages.grafana.com/gpg.key && \
    echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://packages.grafana.com/oss/deb stable main" \
      > /etc/apt/sources.list.d/grafana.list

# 3) Grafana'yı yükleyin
RUN apt-get update && \
    apt-get install -y --no-install-recommends grafana && \
    rm -rf /var/lib/apt/lists/*

# (İsteğe bağlı) Varsayılan log/konfig klasörleri
# RUN mkdir -p /var/lib/grafana /etc/grafana && \
#     chown -R grafana:grafana /var/lib/grafana /etc/grafana

# COPY conf/provisioning /etc/grafana/provisioning
COPY conf/provisioning /usr/share/grafana/conf/provisioning


EXPOSE 3000

CMD ["/usr/share/grafana/bin/grafana", \
     "server", \
     "--homepath=/usr/share/grafana", \
     "--config=/etc/grafana/grafana.ini", \
     "--packaging=deb", \
     "cfg:default.paths.logs=/var/log/grafana", \
     "cfg:default.paths.data=/var/lib/grafana", \
     "cfg:default.paths.plugins=/var/lib/grafana/plugins"]
