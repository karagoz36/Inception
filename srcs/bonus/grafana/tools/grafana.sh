#!/bin/bash

echo "Grafana Configuration for admin user..."
export GF_SECURITY_ADMIN_PASSWORD=$(cat /run/secrets/grafana_admin_password)

echo "Starting Grafana..."
exec "$@"