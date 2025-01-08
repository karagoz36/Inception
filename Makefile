# Makefile for Inception - Docker Compose

COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_DIR = $(HOME)/data
MARIADB_DATA_DIR = $(DATA_DIR)/mariadb_data
WORDPRESS_DATA_DIR = $(DATA_DIR)/wordpress_data
PROMETHEUS_DATA_DIR = $(DATA_DIR)/prometheus_data
GRAFANA_DATA_DIR = $(DATA_DIR)/grafana_data


all: up

# Start Docker Compose services
up: secret
	mkdir -p $(MARIADB_DATA_DIR) $(WORDPRESS_DATA_DIR) $(PROMETHEUS_DATA_DIR) $(GRAFANA_DATA_DIR)
	docker compose -f $(COMPOSE_FILE) up -d --build
	@$(MAKE) --no-print-directory desecret

# Stop and remove Docker Compose services
down: secret
	docker compose -f $(COMPOSE_FILE) down
	@$(MAKE) --no-print-directory desecret

# Start previously stopped Docker Compose services
start: secret
	docker compose -f $(COMPOSE_FILE) start
	@$(MAKE) --no-print-directory desecret

# Stop Docker Compose services
stop: secret
	docker compose -f $(COMPOSE_FILE) stop
	@$(MAKE) --no-print-directory desecret

# Restart Docker Compose services
restart: 
	$(MAKE) down
	$(MAKE) up

# Show logs for all services
logs: secret
	docker compose -f $(COMPOSE_FILE) logs -f
	@$(MAKE) --no-print-directory desecret

# Check status of services
status: secret
	docker compose -f $(COMPOSE_FILE) ps
	@$(MAKE) --no-print-directory desecret

# Show running processes in all services
ps: secret
	@for service in wordpress mariadb nginx redis adminer ftp prometheus node-exporter grafana; do \
	  echo "Processes in $$service:"; \
	  docker compose -f $(COMPOSE_FILE) exec $$service ps aux; \
	  echo "---------------------------------"; \
	done
	@$(MAKE) --no-print-directory desecret

# Generate output file with tree and file contents
out:
	@bash -c '{ tree; find . -type f \( -name ".env" -or ! -path "*/.*" \) -and ! -path "./srcs/bonus/static-website/*" -exec echo "=== {} ===" \; -exec cat {} \; ; } > output.txt'
# Remove containers, volumes, and networks
clean: secret
	docker compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	@read -p "Are you sure you want to delete data directories? [y/N] " confirm && [ $${confirm} = "y" ] && sudo rm -rf $(MARIADB_DATA_DIR) $(WORDPRESS_DATA_DIR) $(PROMETHEUS_DATA_DIR) $(GRAFANA_DATA_DIR) || echo "Aborted."
	@$(MAKE) --no-print-directory desecret

# Full clean: Purge all Docker data after confirmation
fclean:
	@read -p "Are you sure you want to remove all Docker data (containers, images, volumes, caches)? [y/N] " confirm && [ $${confirm} = "y" ] && docker system prune -a --volumes --force || echo "Aborted."

# Add secrets: Copy secrets and .env files
secret:
	@mkdir -p ./secrets
	@if [ -d /home/tkaragoz/credentials/secrets ]; then \
		cp -r /home/tkaragoz/credentials/secrets/* ./secrets/ || echo "Failed to copy secrets."; \
	else \
		echo "No secrets directory found at /home/tkaragoz/credentials/secrets."; \
	fi
	@mkdir -p ./srcs
	@if [ -f /home/tkaragoz/credentials/.env ]; then \
		cp /home/tkaragoz/credentials/.env ./srcs/ || echo "Failed to copy .env file."; \
	else \
		echo "No .env file found at /home/tkaragoz/credentials/.env."; \
	fi
	@echo "Secrets copied successfully."

# Remove secrets and .env files
desecret:
	@rm -rf ./secrets ./srcs/.env
	@echo "Secrets and .env files removed successfully."

# Default command: show help
help:
	@echo "Available commands:"
	@echo "  make up          - Start the Docker Compose services"
	@echo "  make down        - Stop and remove the Docker Compose services"
	@echo "  make start       - Start previously stopped services"
	@echo "  make stop        - Stop the Docker Compose services"
	@echo "  make restart     - Restart the Docker Compose services"
	@echo "  make logs        - Show logs for all services"
	@echo "  make status      - Show the status of services"
	@echo "  make ps          - Show running processes in all services"
	@echo "  make out         - Generate output.txt with tree and file contents"
	@echo "  make clean       - Remove all containers, volumes, and networks"
	@echo "  make fclean      - Completely clean Docker (containers, images, volumes, caches) after confirmation"
	@echo "  make secret      - Copy secrets and .env files from local disk"
	@echo "  make desecret    - Remove secrets and .env files"

.PHONY: help all up down start stop restart logs status ps out clean fclean secret desecret
