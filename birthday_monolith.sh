#!/bin/bash
# --- JOSIE-CORE: THE BIRTHDAY MONOLITH (V22-FINAL) ---
TARGET_IP="100.66.159.200"

echo "[1/3] PURGING THE OLD SYSTEM..."
# Force clear APT and PIP noise one last time
rm -rf /var/lib/apt/lists/*
pip install --break-system-packages -q firecrawl-py > /dev/null 2>&1

echo "[2/3] INJECTING PRO-TIER TOOLS..."
adb connect $TARGET_IP:42015
# Pushing the clean, multi-tab terminal & permission engine
adb install -r shizuku.apk > /dev/null 2>&1
adb install -r ashell.apk > /dev/null 2>&1

echo "[3/3] ACTIVATING SOVEREIGNTY..."
# Locking 384 DPI and sending the system-wide notification
adb shell "wm density 384"
adb shell "pm disable-user --user 0 com.google.android.as"
adb shell "cmd notification post -t 'JOSIE-CORE' 'BIRTHDAY' 'Monolith Active: System Reborn at 384 DPI'"

echo "[SUCCESS] The system is now a self-contained monolith."
