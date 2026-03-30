#!/bin/bash
# --- JOSIE-CORE: UNIFIED MONOLITH ENGINE (CRAX-V22 PROTOCOL) ---
TARGET_IP="100.66.159.200"
FC_KEY="fc-42478c3e37e44d86ad5d6a3c94c5628b"

echo "[1/4] STABILIZING DEBIAN & INJECTING FIRECRAWL..."
# Fix APT headers and install dependencies
echo "Acquire::ForceIPv4 \"true\";" > /etc/apt/apt.conf.d/99force-ipv4
rm -rf /var/lib/apt/lists/*
apt-get update -y && apt-get install -y nmap adb git gh python3-pip
pip install --break-system-packages -q firecrawl-py google-generativeai

echo "[2/4] HUNTING GHOST-SHELL PORT..."
# Scan for the active Wireless Debugging port
ACTIVE_PORT=$(nmap -p 30000-49000 $TARGET_IP --open -Pn | grep "tcp open" -B 1 | grep -oP '\d+(?=/tcp)')
[[ -z "$ACTIVE_PORT" ]] && ACTIVE_PORT="42015"

echo "[3/4] HARDWARE HANDSHAKE & DPI CALIBRATION..."
adb kill-server && adb start-server
adb connect $TARGET_IP:$ACTIVE_PORT
sleep 2

if adb devices | grep -q "$TARGET_IP:$ACTIVE_PORT"; then
    # Lock 411 DPI and post notification to device
    adb shell "wm density 411; settings put secure display_density_forced 411"
    adb shell "cmd notification post -t 'JOSIE-CORE' 'Handshake' 'Monolith Stable at 411 DPI'"
fi

echo "[4/4] IMMORTALIZING BUILD TO GITHUB..."
cd ~/Monolith-Core-Global
git add .
git commit -m "Integrated Firecrawl & Gemini Core: Unified Monolith Engine V22"
git push origin main --force
