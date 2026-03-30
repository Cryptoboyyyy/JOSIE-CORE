#!/bin/bash
# --- JOSIE-CORE: MONOLITH V22 (FINAL HANDSHAKE) ---
TARGET_IP="100.66.159.200"

# 1. ENVIRONMENT STABILIZATION
echo "[1/4] Stabilizing Debian Trixie Environment..."
echo "Acquire::ForceIPv4 \"true\";" > /etc/apt/apt.conf.d/99force-ipv4
rm -rf /var/lib/apt/lists/*
apt-get update -y && apt-get install -y nmap adb git gh

# 2. AUTOMATED BRIDGE DISCOVERY
echo "[2/4] Scanning for Active Ghost-Shell Port..."
ACTIVE_PORT=$(nmap -p 30000-49000 $TARGET_IP --open -Pn | grep "tcp open" -B 1 | grep -oP '\d+(?=/tcp)')

if [ -z "$ACTIVE_PORT" ]; then
    ACTIVE_PORT="42015"
    echo "[!] Port not detected, falling back to 42015."
fi

# 3. HARDWARE CALIBRATION
echo "[3/4] Establishing Hardware Bridge on Port $ACTIVE_PORT..."
adb kill-server && adb start-server
adb connect $TARGET_IP:$ACTIVE_PORT
sleep 2

# Verify and lock 411 DPI
if adb devices | grep -q "$TARGET_IP:$ACTIVE_PORT"; then
    echo "[SUCCESS] Bridge Stabilized. Enforcing Tablet-Mode DPI..."
    adb shell "wm density 411; settings put secure display_density_forced 411"
    adb shell "cmd notification post -t 'JOSIE-CORE' 'Handshake' 'System Fully Synchronized'"
fi

# 4. GITHUB IMMORTALITY
echo "[4/4] Syncing Final Build to GitHub..."
cd ~/Monolith-Core-Global
git add .
git commit -m "Final Monolith Integration: Network, Bridge, and UI Stabilized"
git push origin main --force
