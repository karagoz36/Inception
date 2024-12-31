#!/bin/bash

if [ ! -f "/var/www/html/adminer/index.php" ]; then
    echo "Downloading Adminer..."
    if ! curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o index.php; then
        echo "Error downloading Adminer. Exiting."
        exit 1
    fi
fi

echo "Starting Adminer..."

exec "$@"
