#!/bin/bash

# Perbarui paket sistem
echo "Memperbarui paket sistem..."
sudo apt update && sudo apt upgrade -y

# Instal Apache
echo "Menginstal Apache..."
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2

# Instal PHP dan semua ekstensi yang diperlukan untuk Laravel
echo "Menginstal PHP dan ekstensi yang diperlukan untuk Laravel..."
sudo apt install php libapache2-mod-php php-cli php-mbstring php-xml php-bcmath php-curl php-zip php-intl php-soap php-tokenizer php-common unzip -y

# Instal PostgreSQL
echo "Menginstal PostgreSQL..."
sudo apt install postgresql postgresql-contrib -y
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Konfigurasi PostgreSQL
echo "Mengkonfigurasi PostgreSQL..."
POSTGRES_DB="eraporsmk"
POSTGRES_USER="eraporsmk"
POSTGRES_PASSWORD="eraporsmk"
sudo -u postgres psql -c "CREATE DATABASE ${POSTGRES_DB};"
sudo -u postgres psql -c "CREATE USER ${POSTGRES_USER} WITH PASSWORD '${POSTGRES_PASSWORD}';"
sudo -u postgres psql -c "GRANT CONNECT ON DATABASE ${POSTGRES_DB} TO ${POSTGRES_USER};"
sudo -u postgres psql -d ${POSTGRES_DB} -c "GRANT USAGE, SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO ${POSTGRES_USER};"
sudo -u postgres psql -d ${POSTGRES_DB} -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO ${POSTGRES_USER};"

# Restart layanan untuk memastikan semuanya berjalan
echo "Restart layanan Apache..."
sudo systemctl restart apache2
echo "Restart layanan PostgreSQL..."
sudo systemctl restart postgresql

# Informasi hasil instalasi
echo "Instalasi selesai."
echo "Server Anda telah dikonfigurasi dengan:"
echo "- Apache (dengan modul PHP)"
echo "- PHP dengan ekstensi untuk Laravel (mbstring, xml, bcmath, curl, zip, intl, soap, tokenizer)"
echo "- PostgreSQL (database server)"
echo "Database: ${POSTGRES_DB}"
echo "User: ${POSTGRES_USER}"
echo "Password: ${POSTGRES_PASSWORD}"
echo "Unggah aplikasi Anda ke direktori /var/www/html untuk menggunakannya."
