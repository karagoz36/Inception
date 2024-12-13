# Makefile for Inception - Docker Compose

COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_DIR = ${HOME}/data
MARIADB_DATA_DIR = $(DATA_DIR)/mariadb_data
WORDPRESS_DATA_DIR = $(DATA_DIR)/wordpress_data

all: up

# Start Docker Compose services
up:
	mkdir -p $(MARIADB_DATA_DIR)
	mkdir -p $(WORDPRESS_DATA_DIR)
	docker compose -f $(COMPOSE_FILE) up -d --build

# Stop and remove Docker Compose services
down:
	docker compose -f $(COMPOSE_FILE) down

# Start previously stopped Docker Compose services
start:
	docker compose -f $(COMPOSE_FILE) start

# Restart Docker Compose services
restart:
	$(MAKE) down
	$(MAKE) up

# Show logs for all services
logs:
	docker compose -f $(COMPOSE_FILE) logs -f

# Check status of services
status:
	docker compose -f $(COMPOSE_FILE) ps

# Remove containers, volumes, and networks
clean:
  docker compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
  @read -p "Are you sure you want to delete data directories? [y/N] " confirm && [ $${confirm} = "y" ] && rm -rf $(MARIADB_DATA_DIR) $(WORDPRESS_DATA_DIR) || echo "Aborted."
	
# Default command: show help
help:
	@echo "Available commands:"
	@echo "  make up          - Start the Docker Compose services"
	@echo "  make down        - Stop and remove the Docker Compose services"
	@echo "  make start       - Start previously stopped services"
	@echo "  make restart     - Restart the Docker Compose services"
	@echo "  make logs        - Show logs for all services"
	@echo "  make status      - Show the status of services"
	@echo "  make clean       - Remove all containers, volumes, and networks"

.PHONY: help all up down start restart logs status clean
