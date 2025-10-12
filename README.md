# 🧰 Ubuntu Maintenance Script

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Build Status](https://img.shields.io/badge/Status-Stable-success.svg)](https://github.com/Data-Informasi/ubuntu-maintenance)
[![Made with Bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![Ubuntu](https://img.shields.io/badge/Tested%20on-Ubuntu%2020.04%2B-orange.svg)](https://ubuntu.com/)

Skrip shell otomatis untuk melakukan **perawatan sistem Ubuntu secara menyeluruh**.  Dijalankan sebagai **root**, skrip ini membantu menjaga performa, stabilitas, dan kesehatan sistem tanpa perlu interaksi manual.

---

## 🚀 Fitur Utama

1. 🔧 **Pembaruan Sistem Otomatis**  
   - Menjalankan `apt-get update`, `upgrade`, dan `dist-upgrade`  
   - Memperbaiki paket rusak dan dependensi yang hilang  

2. 🧹 **Pembersihan Sistem Mendalam**  
   - Menghapus cache APT, file sementara, log lama, dan paket yatim  
   - Menghapus isi `/tmp`, `journalctl` lebih dari 10 hari, dan file sampah lain  

3. 💾 **Optimalisasi Ruang Disk**  
   - Membersihkan direktori cache dan log besar  
   - Menjaga ruang penyimpanan tetap efisien  

4. 🧠 **Tes Memori Otomatis (RAM)**  
   - Memastikan `memtester` terpasang  
   - Menjalankan uji memori ringan setelah perawatan  

5. 🧱 **Pemeriksaan Disk (fsck)**  
   - Menandai pemeriksaan disk otomatis pada boot berikutnya (`/forcefsck`)  

6. 🔁 **Restart Otomatis**  
   - Sistem akan restart otomatis setelah seluruh proses selesai  

---

## 🖥️ Cara Menggunakan

1. Unduh atau salin file `maintenance-ubuntu.sh` ke sistemmu
   ```bash
   sudo wget https://raw.githubusercontent.com/informasidata91-cpu/Maintenance-Ubuntu/main/maintenance-ubuntu.sh -O /usr/local/bin/maintenance-ubuntu.sh
2. Jadikan file dapat dieksekusi:
   ```bash
   sudo chmod +x /usr/local/bin/maintenance-ubuntu.sh
   ```
3. Jalankan sebagai **root**:
   ```bash
   sudo /usr/local/bin/maintenance-ubuntu.sh
   ```
4. Biarkan skrip berjalan hingga selesai — semua langkah berjalan otomatis  

---

## 🕒 Menjadwalkan Otomatis (Opsional)

Untuk menjalankan skrip secara rutin (misalnya setiap Minggu pukul 03:00 pagi), tambahkan ke **cron**:

```bash
sudo crontab -e
```

Lalu tambahkan baris berikut:
```bash
0 3 * * 0 /path/to/maintenance-ubuntu.sh >> /var/log/maintenance.log 2>&1
```
### 🧩 Penjelasan Baris Demi Baris  

| Bagian                           | Arti                           | Keterangan                                                                                                                            |
| -------------------------------- | ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------- |
| `0`                              | **Menit**                      | Skrip dijalankan pada menit ke-0 (tepat di awal jam).                                                                                 |
| `3`                              | **Jam**                        | Skrip dijalankan pukul **03:00 pagi**.                                                                                                |
| `*`                              | **Tanggal (hari dalam bulan)** | Simbol `*` berarti **setiap tanggal**.                                                                                                |
| `*`                              | **Bulan**                      | Simbol `*` berarti **setiap bulan**.                                                                                                  |
| `0`                              | **Hari dalam minggu**          | Nilai `0` berarti **Minggu**. (1=Senin, 2=Selasa, dst).                                                                               |
| `/path/to/maintenance-ubuntu.sh` | **Perintah utama**             | Lokasi lengkap skrip maintenance yang akan dijalankan. Ganti dengan path sebenarnya, misalnya `/usr/local/bin/maintenance-ubuntu.sh`. |
| `>> /var/log/maintenance.log`    | **Output log**                 | Menyimpan hasil keluaran (stdout) dari skrip ke file log `/var/log/maintenance.log`. Jika file belum ada, akan dibuat otomatis.       |
| `2>&1`                           | **Redirect error**             | Mengarahkan keluaran error (stderr) ke tempat yang sama dengan keluaran biasa (stdout), sehingga **semua pesan** masuk ke log.        |  

### 🛠️ Contoh versi lengkap (setelah disesuaikan)
```bash
0 3 * * 0 /usr/local/bin/maintenance-ubuntu.sh >> /var/log/maintenance.log 2>&1
```  
Dengan ini, sistem kamu akan otomatis melakukan perawatan mingguan tanpa perlu menjalankan skrip manual.  

---

## Distribusi yang Kompatibel Langsung  
Skrip `maintenance-ubuntu.sh` digunakan untuk melakukan pemeliharaan sistem pada Linux berbasis Ubuntu/Debian. Skrip ini dapat dijalankan tanpa modifikasi pada distribusi berikut:
- Ubuntu (semua versi yang masih didukung)
- Debian (misal Debian 10, 11, dst.)
- Linux Mint (berbasis Ubuntu/Debian)
- Pop!_OS (berbasis Ubuntu)
- Elementary OS (berbasis Ubuntu)
- Zorin OS (berbasis Ubuntu)

## 📂 Struktur Proyek

```
.
├── maintenance-ubuntu.sh   # Skrip utama perawatan Ubuntu
├── LICENSE                 # Lisensi MIT resmi
└── README.md               # Dokumentasi proyek
```

---

## 🧾 Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE) © 2025 **Data Informasi**.  
Anda bebas menggunakan, menyalin, memodifikasi, dan mendistribusikan proyek ini untuk tujuan apa pun, selama menyertakan pemberitahuan hak cipta dan lisensi ini.

---

## 🤝 Kontribusi

Kontribusi terbuka untuk siapa pun!  
Silakan buat **pull request** untuk menambahkan fitur baru atau memperbaiki bug.

---

## 🧩 Tentang

Dikembangkan oleh **Data Informasi**  
Tujuan: mempermudah perawatan sistem Ubuntu secara otomatis, aman, dan efisien.

---

## 🌐 Tautan Penting

- 💻 Repo GitHub: [https://github.com/Data-Informasi/ubuntu-maintenance](https://github.com/Data-Informasi/ubuntu-maintenance)
- 📄 Lisensi: [MIT License](LICENSE)
- 🐧 Sistem yang Didukung: Ubuntu 20.04, 22.04, dan versi terbaru

---

## Support Us / Dukung Kami

If you like this project, consider supporting us via GitHub Sponsors:  
Jika kamu menyukai proyek ini, pertimbangkan untuk mendukung kami melalui GitHub Sponsors:

[![Sponsor](https://img.shields.io/badge/Sponsor-❤️-pink?style=flat&logo=GitHub)](https://github.com/informasidata91-cpu)  
