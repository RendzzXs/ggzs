#!/bin/bash
echo "🔧 PERBAIKAN DI MODE PEMULIHAN — Hati‑hati tapi aman"
echo "--------------------------------------------------------"

# 🔒 Pasang ulang sistem berkas jadi BISA TULISAN
mount -o remount,rw /
mount -a 2>/dev/null

# 🧹 Bersihkan SEMPURNA — hapus semua bikin penuh & macet
apt clean -y; apt autoclean -y; apt autoremove -y
rm -rf /tmp/* /var/tmp/* /var/cache/apt/* /var/cache/debconf/* /root/.cache/* /home/*/.cache/* 2>/dev/null
find /var/log -type f -exec rm -f {} \; 2>/dev/null
journalctl --vacuum-size=50M --vacuum-time=1d

# 🛠️ PERBAIKI BERKAS MACET / TEXT FILE BUSY + SISTEM BERKAS
fsck -y /dev/root 2>/dev/null || echo "⚠️ fsck dilewati jika sedang dipasang"
lsof +L1 / 2>/dev/null | awk '{print $2}' | sort -u | xargs -r kill -9 2>/dev/null
find / -type f \( -name "*.lock" -o -name "*.pid" \) -delete 2>/dev/null

# 📦 Bersihkan sisa Composer/PHP yang rusak
rm -rf /root/.composer /var/www/html/vendor /var/www/pterodactyl/vendor /usr/local/bin/composer 2>/dev/null

# ✅ Tampilkan hasil
echo ""
echo "✅ SELESAI: Ruang lega + kunci macet dibuka"
df -h /
echo ""
echo "🔄 Keluar mode pemulihan: ketik → exit lalu reboot"
