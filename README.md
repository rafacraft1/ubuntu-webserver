# Setup Web Server(Apache, PHP, MySQL)

Skrip ini menyediakan cara otomatis untuk menginstal dan mengonfigurasi **Apache**, **PHP** dan **MySQL** pada **Ubuntu Server**.

## Fitur
- Instalasi **Apache** sebagai server web.
- Instalasi **PHP** dengan ekstensi :
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
