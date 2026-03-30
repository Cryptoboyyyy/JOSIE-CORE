#!/bin/bash
TARGET_IP="100.66.159.200:39083"

echo "[+] Monolith-Core: Re-establishing Hardware Handshake..."
adb kill-server && adb start-server
adb connect $TARGET_IP

if adb devices | grep -q "$TARGET_IP"; then
    echo "[+] Handshake Verified. Enforcing 411 DPI..."
    # Global System Override for Pixel 9 Pro XL
    adb shell "wm density 411; settings put secure display_density_forced 411"
    adb shell "cmd notification post -t 'MONOLITH-CORE' 'Status' 'System Calibrated to 411 DPI'"
else
    echo "[!] Critical Error: Bridge Offline. Check Wireless Debugging."
fi
