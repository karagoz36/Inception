# Inception

Inception is a project designed to teach container-based infrastructure management using **Docker**. The goal is to set up various services in isolated containers and manage them efficiently.

## 📌 About the Project

This project involves setting up a **multi-container environment** with several services, including:

- **Docker & Docker-Compose**
- **Nginx (Reverse Proxy)**
- **WordPress (CMS Platform)**
- **MariaDB (Database Management)**
- **Redis (Caching Service)**
- **Adminer (Database Management Tool)**
- **VSFTPD (FTP Server)**
- **Grafana & Prometheus (Monitoring Services)**
- **Node Exporter (System Metrics Exporter)**
- **Static Website Hosting**

## 📂 Project Structure

```
📦 inception
 ┣ 📂 srcs                # Service configuration files
 ┃ ┣ 📂 bonus             # Bonus services
 ┃ ┃ ┣ 📂 adminer         # Adminer setup
 ┃ ┃ ┣ 📂 ftp             # FTP server setup
 ┃ ┃ ┣ 📂 grafana         # Grafana configuration
 ┃ ┃ ┣ 📂 node-exporter   # Node exporter setup
 ┃ ┃ ┣ 📂 prometheus      # Prometheus configuration
 ┃ ┃ ┣ 📂 redis           # Redis setup
 ┃ ┃ ┗ 📂 static-website  # Static website hosting
 ┃ ┃   ┣ 📂 tools         # Scripts and configurations
 ┃ ┃   ┃ ┣ 📂 static_web_pages
 ┃ ┃   ┃ ┃ ┣ 📂 images    # Static website images
 ┃ ┃   ┃ ┃ ┣ 📂 recipes   # HTML recipe pages
 ┃ ┃   ┃ ┃ ┣ 📜 index.html
 ┃ ┃   ┃ ┃ ┣ 📜 script.js
 ┃ ┃   ┃ ┃ ┗ 📜 styles.css
 ┃ ┣ 📂 requirements      # Core service configurations
 ┃ ┃ ┣ 📂 mariadb         # MariaDB setup
 ┃ ┃ ┣ 📂 nginx          # Nginx setup
 ┃ ┃ ┗ 📂 wordpress      # WordPress setup
 ┣ 📄 docker-compose.yml  # Docker Compose configuration
 ┣ 📄 Makefile            # Makefile for project management
 ┣ 📄 README.md           # Project documentation
```

## 🚀 Setup & Installation

Ensure that **Docker** and **Docker-Compose** are installed before proceeding.

```sh
# 1. Navigate to the project directory
cd inception

# 2. Set up environment variables
cp srcs/.env.example srcs/.env  # Copy environment variables
nano srcs/.env                   # Edit if necessary

# 3. Configure the local domain name
sudo nano /etc/hosts
```

Add the following line at the end of the file:
```sh
127.0.0.1 tkaragoz.42.fr adminer.tkaragoz.42.fr prometheus.tkaragoz.42.fr grafana.tkaragoz.42.fr tkaragoz.42.fr/static/
```

# 4. Update Nginx configuration
Make sure your **server_name** directive in the Nginx configuration file reflects the same domain names:
```nginx
server_name tkaragoz.42.fr
adminer.tkaragoz.42.fr
prometheus.tkaragoz.42.fr
grafana.tkaragoz.42.fr
tkaragoz.42.fr/static/;
```

# 5. Build and start the services
```sh
make up
```

Once the services are running, you can access:
- **WordPress** at **http://tkaragoz.42.fr**
- **Adminer** at **http://adminer.tkaragoz.42.fr**
- **Grafana** at **http://grafana.tkaragoz.42.fr**
- **Prometheus** at **http://prometheus.tkaragoz.42.fr**
- **Static Website** at **http://tkaragoz.42.fr/static/**

## 📜 Available Commands

To manage the project efficiently, use the following `make` commands:

```sh
make up             # Start all services
make down           # Stop and remove all containers
make start          # Start previously stopped services
make stop           # Stop the Docker Compose services
make restart        # Restart the Docker Compose services
make logs           # Show logs for all services
make status         # Show the status of services
make ps             # Show running processes in all services
make out            # Generate output.txt with tree and file contents
make clean          # Remove all containers, volumes, and networks
make fclean         # Completely clean Docker (containers, images, volumes, caches) after confirmation
make secret         # Copy secrets and .env files from local disk
make desecret       # Remove secrets and .env files
```

## 🔐 Secrets Management

This project uses **Docker Secrets** for managing sensitive credentials. The following secrets are stored securely:

- **mysql_password** (stored in `../secrets/mysql_password.txt`)
- **mysql_root_password** (stored in `../secrets/mysql_root_password.txt`)
- **wp_admin_password** (stored in `../secrets/wp_admin_password.txt`)
- **wp_user_password** (stored in `../secrets/wp_user_password.txt`)
- **ftp_password** (stored in `../secrets/ftp_password.txt`)
- **grafana_admin_password** (stored in `../secrets/grafana_admin_password.txt`)

## 🎯 Learning Objectives

Through this project, you will gain in-depth knowledge on:

- **Docker & Containerization Concepts**
- **Multi-Service Management with Docker-Compose**
- **Reverse Proxy Usage (Nginx)**
- **WordPress & MariaDB Integration**
- **Redis for Caching Mechanisms**
- **FTP Server Setup and Configuration**
- **Monitoring Services (Grafana, Prometheus, Node Exporter)**
- **Hosting a Static Website in a Container**
- **Using Docker Secrets for Secure Credentials Management**
- **Local Domain Name Configuration with /etc/hosts**

## 📖 Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [MariaDB Documentation](https://mariadb.org/)
- [Grafana Documentation](https://grafana.com/docs/)
- [Prometheus Documentation](https://prometheus.io/docs/)
