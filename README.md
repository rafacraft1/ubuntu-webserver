# Setup Web Server untuk Laravel (Apache, PHP, MySQL)

Skrip ini menyediakan cara otomatis untuk menginstal dan mengonfigurasi **Apache**, **PHP (dengan ekstensi yang dibutuhkan Laravel)**, dan **MySQL** pada **Ubuntu Server**. Setelah menjalankan skrip ini, server Anda akan siap untuk menjalankan aplikasi **Laravel**.

## Fitur
- Instalasi **Apache** sebagai server web.
- Instalasi **PHP** dengan ekstensi yang dibutuhkan untuk Laravel:
  - `mbstring`, `xml`, `bcmath`, `curl`, `zip`, `intl`, `soap`, `tokenizer`, `mysql`.
- Instalasi **MySQL** dan konfigurasi password root secara otomatis.
- Restart layanan **Apache** dan **MySQL** setelah instalasi selesai.

---

## Prasyarat
- **Ubuntu Server** dengan akses root atau sudo.
- **Koneksi internet** untuk mengunduh paket-paket yang dibutuhkan.

---

## Cara Menggunakan

### 1. Clone Repositori

Untuk memulai, Anda perlu menyalin repositori ke server Anda. Jalankan perintah berikut untuk meng-clone repositori ke direktori lokal:

```bash
git clone https://github.com/rafacraft1/ubuntu-webserver.git
cd ubuntu-webserver
chmod +x install.sh
./install.sh
