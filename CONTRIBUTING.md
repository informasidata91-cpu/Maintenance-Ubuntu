# Panduan Kontribusi

Terima kasih telah tertarik untuk berkontribusi pada proyek **Maintenance-Ubuntu** 🎉  
Kontribusi Anda membantu menjaga proyek ini tetap berkembang, stabil, dan bermanfaat bagi banyak pengguna Ubuntu di seluruh dunia.

---

## 💡 Cara Berkontribusi

Ada beberapa cara Anda dapat berkontribusi:

1. **Melaporkan Bug**
   - Periksa apakah bug sudah pernah dilaporkan di tab **Issues**.
   - Jika belum, buat issue baru dengan format berikut:
     - Langkah untuk mereproduksi bug
     - Hasil yang diharapkan dan hasil aktual
     - Informasi sistem (`lsb_release -a`, `uname -r`)
     - Log terkait (jika ada)

2. **Mengajukan Fitur Baru**
   - Gunakan label `enhancement` saat membuat issue baru.
   - Jelaskan alasan fitur diperlukan dan dampak positifnya.

3. **Memperbaiki Kode atau Dokumentasi**
   - Fork repositori ini
   - Buat branch baru:
     ```bash
     git checkout -b fitur-anda
     ```
   - Lakukan perubahan dan commit secara jelas:
     ```bash
     git commit -m "Menambahkan fitur X atau memperbaiki Y"
     ```
   - Push ke branch Anda:
     ```bash
     git push origin fitur-anda
     ```
   - Ajukan **Pull Request (PR)** ke branch `main`.

---

## 🧰 Standar Kode

- Gunakan gaya penulisan **Bash yang aman dan rapi**:
  - Gunakan `set -euo pipefail` di awal skrip.
  - Hindari hard-coded path bila memungkinkan.
  - Gunakan `echo` dengan format yang konsisten untuk log output.
- Pastikan skrip berjalan tanpa interaksi manual.
- Uji skrip Anda di **Ubuntu LTS (20.04 / 22.04 / 24.04)** sebelum mengirim PR.
- Dokumentasikan perubahan Anda di `README.md` jika ada perintah baru.

---

## ⚙️ Development Setup

Langkah-langkah untuk menyiapkan lingkungan pengembangan lokal:

```bash
# 1. Clone repositori
git clone https://github.com/informasidata91-cpu/Maintenance-Ubuntu.git
cd Maintenance-Ubuntu

# 2. Pastikan skrip bisa dijalankan
chmod +x maintenance-ubuntu.sh

# 3. Jalankan skrip di mode pengujian
sudo bash maintenance-ubuntu.sh

# 4. Periksa log hasil
sudo less /var/log/maintenance_ubuntu.log
```

Jika Anda menambahkan fungsi baru, uji di sistem lokal atau virtual machine
sebelum membuat Pull Request.

---

## 🧪 Pengujian

Sebelum mengirimkan perubahan, pastikan semua fungsi utama berjalan dengan benar:
```bash
sudo bash maintenance-ubuntu.sh
```
Pastikan tidak ada error, interaksi manual, atau konflik sistem.

---

## 🗣️ Kode Etik

Semua kontributor diharapkan mengikuti pedoman perilaku yang dijelaskan di:
[CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md)

---

## 📬 Pertanyaan atau Bantuan

Jika Anda memiliki pertanyaan, saran, atau ingin berdiskusi,
hubungi pengelola proyek melalui:

📧 **informasidata91@gmail.com**

---

## ❤️ Terima Kasih

Kontribusi Anda sangat berarti — baik besar maupun kecil.  
Setiap baris kode, laporan bug, atau saran membantu proyek ini menjadi lebih baik.
