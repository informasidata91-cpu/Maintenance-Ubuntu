#!/bin/bash
# ==========================================================
#  Skrip Pemeliharaan Sistem Ubuntu Otomatis
#  Versi: 1.0
#  Dibuat oleh: Data Informasi (2025)
# ==========================================================

set -euo pipefail
LOGFILE="/var/log/maintenance_ubuntu.log"
exec > >(tee -a "$LOGFILE") 2>&1
START=$(date +%s)

echo "=== MEMULAI PROSES PERAWATAN SISTEM UBUNTU ($(date)) ==="

# ----------------------------------------------------------
# 1. Memeriksa koneksi internet
# ----------------------------------------------------------
echo "[1/13] Memeriksa koneksi internet..."
if ping -c 1 8.8.8.8 &>/dev/null; then
    echo "Koneksi internet OK."
else
    echo "Tidak ada koneksi internet. Beberapa langkah mungkin gagal."
fi

# ----------------------------------------------------------
# 2. Memperbarui daftar paket
# ----------------------------------------------------------
echo "[2/13] Memperbarui daftar paket (apt update)..."
apt-get update -y -qq

# ----------------------------------------------------------
# 3. Melakukan peningkatan paket sistem
# ----------------------------------------------------------
echo "[3/13] Meningkatkan paket sistem (apt upgrade)..."
apt-get upgrade -y -qq
apt-get dist-upgrade -y -qq

# ----------------------------------------------------------
# 4. Menghapus paket dan dependensi yang tidak dibutuhkan
# ----------------------------------------------------------
echo "[4/13] Menghapus paket dan dependensi yang tidak dibutuhkan..."
apt-get autoremove -y -qq
apt-get autoclean -y -qq

# ----------------------------------------------------------
# 5. Membersihkan cache APT
# ----------------------------------------------------------
echo "[5/13] Membersihkan cache APT..."
rm -rf /var/lib/apt/lists/*
apt-get clean -y -qq

# ----------------------------------------------------------
# 6. Membersihkan cache Snap
# ----------------------------------------------------------
echo "[6/13] Membersihkan cache Snap..."
if command -v snap &>/dev/null; then
    snap list --all | awk '/disabled/{print $1, $2}' | while read snapname revision; do
        snap remove "$snapname" --revision="$revision" 2>/dev/null || true
    done
    rm -rf /var/lib/snapd/cache/* || true
else
    echo "Snap tidak terinstal, melewati langkah ini."
fi

# ----------------------------------------------------------
# 7. Membersihkan log sistem lama
# ----------------------------------------------------------
echo "[7/13] Membersihkan log sistem lama..."
journalctl --vacuum-time=7d
rm -rf /var/log/*.gz /var/log/*.[0-9] || true

# ----------------------------------------------------------
# 8. Memeriksa dan memperbaiki sistem file
# ----------------------------------------------------------
echo "[8/13] Memeriksa integritas sistem file..."
fsck -Af -y || echo "fsck akan berjalan otomatis pada reboot bila perlu."

# ----------------------------------------------------------
# 9. Memeriksa status dan memperbaiki paket rusak
# ----------------------------------------------------------
echo "[9/13] Memeriksa dan memperbaiki paket rusak..."
dpkg --configure -a
apt-get install -f -y -qq

# ----------------------------------------------------------
# 10. Memeriksa layanan yang gagal
# ----------------------------------------------------------
echo "[10/13] Memeriksa layanan sistem yang gagal..."
systemctl --failed || true

# ----------------------------------------------------------
# 11. Membersihkan direktori sementara
# ----------------------------------------------------------
echo "[11/13] Membersihkan file sementara..."
rm -rf /tmp/* /var/tmp/* || true

# ----------------------------------------------------------
# 12. Mengoptimalkan swap dan memori cache
# ----------------------------------------------------------
echo "[12/13] Mengosongkan cache memori..."
sync; echo 3 > /proc/sys/vm/drop_caches || true
swapoff -a && swapon -a || true
echo "Cache memori dibersihkan."

# ----------------------------------------------------------
# 13. Menjadwalkan reboot otomatis
# ----------------------------------------------------------
echo "[13/13] Menjadwalkan restart sistem..."
echo "Sistem akan restart otomatis dalam 1 menit."
sleep 5
shutdown -r +1 "Maintenance Ubuntu selesai. Sistem akan restart dalam 1 menit."

# ----------------------------------------------------------
# Ringkasan
# ----------------------------------------------------------
END=$(date +%s)
DURATION=$((END - START))
echo "=== PROSES PERAWATAN SELESAI dalam ${DURATION} detik ==="
echo "Log disimpan di: $LOGFILE"
echo "=========================================================="
