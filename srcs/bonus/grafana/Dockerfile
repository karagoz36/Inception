FROM debian:bullseye-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gnupg \
        wget \
        ca-certificates \
        apt-transport-https \
        procps \
        software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# 2) Grafana GPG KEY
RUN wget -q -O /usr/share/keyrings/grafana.key https://packages.grafana.com/gpg.key && \
    echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://packages.grafana.com/oss/deb stable main" \
      > /etc/apt/sources.list.d/grafana.list

# 3) Install Grafana
RUN apt-get update && \
    apt-get install -y --no-install-recommends grafana && \
    rm -rf /var/lib/apt/lists/*

# RUN mkdir -p /var/lib/grafana /etc/grafana && \
#     chown -R grafana:grafana /var/lib/grafana /etc/grafana

COPY conf/provisioning /usr/share/grafana/conf/provisioning

COPY tools/grafana.sh /tools/grafana.sh
RUN chmod +x /tools/grafana.sh

EXPOSE 3000

ENTRYPOINT [ "/tools/grafana.sh" ]

CMD ["/usr/share/grafana/bin/grafana", \
     "server", \
     "--homepath=/usr/share/grafana", \
     "--config=/etc/grafana/grafana.ini", \
     "--packaging=deb", \
     "cfg:default.paths.logs=/var/log/grafana", \
     "cfg:default.paths.data=/var/lib/grafana", \
     "cfg:default.paths.plugins=/var/lib/grafana/plugins"]
