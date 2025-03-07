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

# Install Composer
COMPOSER_INSTALLER="https://getcomposer.org/installer"
INSTALLER_HASH="$(curl -s https://composer.github.io/installer.sig)"
php -r "copy('$COMPOSER_INSTALLER', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$INSTALLER_HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); exit(1); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

# Tambahkan composer ke user biasa
USERNAME="${SUDO_USER:-$(whoami)}"
USER_HOME="$(eval echo ~$USERNAME)"
mkdir -p "$USER_HOME/.local/bin"
composer config --global bin-dir "$USER_HOME/.local/bin"

# Tambahkan PATH user biasa
if ! grep -q "export PATH=\$PATH:\$HOME/.local/bin" "$USER_HOME/.bashrc"; then
  echo "export PATH=\$PATH:\$HOME/.local/bin" >> "$USER_HOME/.bashrc"
fi

# Restart shell agar konfigurasi PATH berlaku
sudo chown -R $USERNAME:$USERNAME "$USER_HOME/.local"
source "$USER_HOME/.bashrc"

# Verifikasi Instalasi
apache2 -v
php -v
composer --version

echo "Instalasi selesai!"
