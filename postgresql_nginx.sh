#!/bin/bash

# Perbarui paket sistem
echo "Memperbarui paket sistem..."
sudo apt update && sudo apt upgrade -y

# Instal Nginx
echo "Menginstal Nginx..."
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx

# Konfigurasi Nginx untuk Laravel
echo "Mengkonfigurasi Nginx untuk Laravel..."
NGINX_CONF="/etc/nginx/sites-available/laravel"
sudo bash -c "cat > ${NGINX_CONF}" <<EOL
server {
    listen 80;
    server_name localhost;
    root /var/www/html/public;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOL
sudo ln -sf /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t && sudo systemctl reload nginx

# Instal PHP dan semua ekstensi yang diperlukan untuk Laravel
echo "Menginstal PHP dan ekstensi yang diperlukan untuk Laravel..."
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install php8.1 php8.1-fpm php8.1-cli php8.1-mbstring php8.1-xml php8.1-bcmath php8.1-curl php8.1-zip php8.1-intl php8.1-soap php8.1-tokenizer php8.1-common unzip -y
sudo systemctl enable php8.1-fpm
sudo systemctl start php8.1-fpm

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
echo "Restart layanan Nginx..."
sudo systemctl restart nginx
echo "Restart layanan PHP-FPM..."
sudo systemctl restart php8.1-fpm
echo "Restart layanan PostgreSQL..."
sudo systemctl restart postgresql

# Informasi hasil instalasi
echo "Instalasi selesai."
echo "Server Anda telah dikonfigurasi dengan:"
echo "- Nginx (dengan dukungan PHP-FPM)"
echo "- PHP 8.1 dengan ekstensi untuk Laravel (mbstring, xml, bcmath, curl, zip, intl, soap, tokenizer)"
echo "- PostgreSQL (database server)"
echo "Database: ${POSTGRES_DB}"
echo "User: ${POSTGRES_USER}"
echo "Unggah aplikasi Anda ke direktori /var/www/html untuk menggunakannya."
