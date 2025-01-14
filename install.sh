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
sudo apt install php libapache2-mod-php php-cli php-mbstring php-xml php-bcmath php-curl php-zip php-intl php-soap php-tokenizer php-common php-mysql unzip -y

# Instal MySQL
echo "Menginstal MySQL..."
sudo apt install mysql-server -y
sudo systemctl enable mysql
sudo systemctl start mysql

# Konfigurasi MySQL
echo "Mengkonfigurasi MySQL..."
MYSQL_ROOT_PASSWORD="rootpassword"
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"

# Restart layanan untuk memastikan semuanya berjalan
echo "Restart layanan Apache dan MySQL..."
sudo systemctl restart apache2
sudo systemctl restart mysql

# Informasi hasil instalasi
echo "Instalasi selesai."
echo "Server Anda telah dikonfigurasi dengan:"
echo "- Apache (dengan modul PHP)"
echo "- PHP dengan ekstensi untuk Laravel (mbstring, xml, bcmath, curl, zip, intl, soap, tokenizer, mysql)"
echo "- MySQL (Password root: ${MYSQL_ROOT_PASSWORD})"
echo "Unggah aplikasi Anda ke direktori /var/www/html untuk menggunakannya."
