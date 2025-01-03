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

# Stop Docker Compose services
stop:
	docker compose -f $(COMPOSE_FILE) stop

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

# Show running processes in all services
ps:
	@for service in wordpress mariadb nginx redis adminer ftp; do \
	  echo "Processes in $$service:"; \
	  docker compose -f $(COMPOSE_FILE) exec $$service ps aux; \
	  echo "---------------------------------"; \
	done

# Generate output file with tree and file contents
out:
	@bash -c '{ tree; find . -type f \( -name ".env" -or ! -path "*/.*" \) -and ! -path "./srcs/bonus/static-website/*" -exec echo "=== {} ===" \; -exec cat {} \; ; } > output.txt'
# @bash -c '{ tree; find . -type f ! -path "*/.*" -and \( -name ".env" -or -not -path "./srcs/bonus/static-website/*" \) -exec echo "=== {} ===" \; -exec cat {} \; ; } >> output.txt'
# Remove containers, volumes, and networks
clean:
	docker compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	@read -p "Are you sure you want to delete data directories? [y/N] " confirm && [ $${confirm} = "y" ] && sudo rm -rf $(MARIADB_DATA_DIR) $(WORDPRESS_DATA_DIR) || echo "Aborted."

# Full clean: Purge all Docker data after confirmation
fclean:
	@read -p "Are you sure you want to remove all Docker data (containers, images, volumes, caches)? [y/N] " confirm && [ $${confirm} = "y" ] && docker system prune -a --volumes --force || echo "Aborted."
	
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

.PHONY: help all up down start stop restart logs status ps out clean fclean
