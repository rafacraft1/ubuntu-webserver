#!/bin/bash

# Update dan upgrade sistem
sudo apt update -y && sudo apt upgrade -y

# Install Apache2
sudo apt install -y apache2

# Aktifkan dan jalankan Apache2
sudo systemctl enable apache2
sudo systemctl start apache2

# Install PHP 8.1 dan extension umum
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update -y
sudo apt install -y php8.1 php8.1-cli php8.1-curl php8.1-mbstring php8.1-xml php8.1-bcmath php8.1-zip php8.1-intl php8.1-gd php8.1-soap php8.1-readline php8.1-mysql php8.1-pgsql php8.1-sqlite3

# Konfigurasi PHP di Apache
sudo a2enmod php8.1
sudo systemctl restart apache2

# Verifikasi Instalasi
apache2 -v
php -v

echo "Instalasi selesai!"
