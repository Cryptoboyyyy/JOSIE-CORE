#!/bin/bash
# --- JOSIE-CORE: UNIVERSAL MONOLITH (V22-AUTO) ---
TARGET_IP="100.66.159.200"
FC_KEY="fc-42478c3e37e44d86ad5d6a3c94c5628b"

echo "[1/4] EXECUTING DEEP-SYSTEM PURGE..."
# Force IPv4 and purge APT locks to prevent 'Waiting for headers' hangs
echo "Acquire::ForceIPv4 \"true\";" > /etc/apt/apt.conf.d/99force-ipv4
rm -rf /var/lib/apt/lists/*
killall apt apt-get dpkg 2>/dev/null
apt-get update -y && apt-get install -y nmap adb git gh python3-pip zip unzip

echo "[2/4] SCANNING GHOST-SHELL DOMAIN..."
# Automated hunt for the Wireless Debugging port (Active Scan)
ACTIVE_PORT=$(nmap -p 30000-49000 $TARGET_IP --open -Pn | grep "tcp open" -B 1 | grep -oP '\d+(?=/tcp)')

if [ -z "$ACTIVE_PORT" ]; then
    echo "[!] Active bridge not found. Forcing last known: 42015"
    ACTIVE_PORT="42015"
fi

echo "[3/4] HARDWARE CALIBRATION (411 DPI)..."
adb kill-server && adb start-server
adb connect $TARGET_IP:$ACTIVE_PORT
sleep 2

if adb devices | grep -q "$TARGET_IP:$ACTIVE_PORT"; then
    echo "[SUCCESS] Handshake Confirmed."
    # Enforce Tablet-Mode Scaling
    adb shell "wm density 411; settings put secure display_density_forced 411"
    adb shell "cmd notification post -t 'JOSIE-CORE' 'Monolith Status' 'Bridge Active on Port $ACTIVE_PORT'"
else
    echo "[ERROR] Handshake Failed. Ensure Pixel 9 Pro XL has Wireless Debugging ON."
fi

echo "[4/4] IMMORTALIZING BUILD TO GITHUB..."
cd ~/Monolith-Core-Global
git add .
git commit -m "Integrated Universal Autonomy: Port Hunt + Header Fix + 411 DPI"
git push origin main --force
