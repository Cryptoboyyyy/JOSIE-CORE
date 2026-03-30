#!/bin/bash
# --- JOSIE-CORE: PRO-TIER DEPLOYMENT ---
TARGET_IP="100.66.159.200"
PORT="42015"

echo "[1/2] Fetching Shizuku & aShell..."
# Downloading the latest stable releases
curl -L "https://github.com/RikkaApps/Shizuku/releases/download/v13.5.4/shizuku-v13.5.4-release.apk" -o shizuku.apk
curl -L "https://github.com/pujie92/aShell/releases/download/v1.2.1/aShell-v1.2.1.apk" -o ashell.apk

echo "[2/2] Injecting into Monolith..."
adb connect $TARGET_IP:$PORT
adb install -r shizuku.apk
adb install -r ashell.apk

# Cleanup
rm *.apk
echo "[SUCCESS] Shizuku and aShell are live. No more noise."
