#!/usr/bin/env bash
# ==========================================================
#  Skrip Perawatan Sistem Ubuntu Otomatis
#  Versi: 2.1 
#  Deskripsi:
#  Memperbarui sistem, memperbaiki paket rusak, membersihkan cache,
#  menjadwalkan fsck, menyiapkan tes RAM, dan melakukan restart otomatis.
#  Jalankan sebagai root.
# ==========================================================

set -euo pipefail

# --- Inisialisasi log ---
LOGFILE="/var/log/maintenance_ubuntu.log"
exec > >(tee -a "$LOGFILE") 2>&1
START=$(date +%s)
echo "=== MEMULAI PROSES PERAWATAN SISTEM UBUNTU ($(date)) ==="

# --- Fungsi utilitas ---
info() { echo "[INFO] $1"; }
warn() { echo "[PERINGATAN] $1"; }

# --- Cek koneksi internet ---
cek_internet() {
    info "Memeriksa koneksi internet..."
    if ping -c1 8.8.8.8 &>/dev/null; then
        info "Koneksi internet aktif."
        NO_NET=0
    else
        warn "Tidak ada koneksi internet. Langkah update sistem akan dilewati."
        NO_NET=1
    fi
}

# --- Perbarui dan perbaiki sistem ---
update_sistem() {
    if [[ $NO_NET -eq 1 ]]; then return; fi
    info "Memperbarui dan memperbaiki sistem..."
    apt-get update -y
    apt-get dist-upgrade -y
    apt-get autoremove --purge -y
    apt-get autoclean -y
    apt-get clean -y
    info "Update dan pembersihan sistem selesai."
}

# --- Perbaiki paket rusak ---
perbaiki_paket() {
    info "Memeriksa dan memperbaiki paket rusak..."
    dpkg --configure -a || true
    apt-get install -f -y || true
}

# --- Bersihkan file sementara dan log ---
bersihkan_file() {
    info "Membersihkan file sementara, cache, dan log lama..."
    find /tmp /var/tmp -type f -mtime +3 -delete 2>/dev/null || true
    journalctl --vacuum-time=10d || true
    rm -rf /var/cache/apt/archives/*.deb || true
    rm -rf /var/lib/apt/lists/* || true
    info "Pembersihan file sementara selesai."
}

# --- Periksa sistem file (fsck) ---
periksa_disk() {
    info "Menjadwalkan pemeriksaan disk (fsck) pada reboot berikutnya..."
    touch /forcefsck
}

# --- Tes RAM (opsional) ---
tes_ram() {
    info "Memastikan utilitas memtester terpasang..."
    apt-get install -y memtester >/dev/null 2>&1 || true
    info "Tes RAM dapat dijalankan manual: sudo memtester 100M 1"
}

# --- Ringkasan hasil ---
ringkasan() {
    END=$(date +%s)
    DURASI=$(( (END - START) / 60 ))
    echo
    info "=== PROSES PERAWATAN SELESAI ==="
    info "Durasi total: ${DURASI} menit"
    info "Log tersimpan di: $LOGFILE"
    info "Sistem akan restart otomatis dalam 30 detik..."
    echo "Selesai pada: $(date)"
    sleep 5
    shutdown -r +0.5 "Perawatan sistem selesai. Komputer akan restart otomatis dalam 30 detik."
}

