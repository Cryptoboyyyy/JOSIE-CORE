#!/bin/bash
# --- JOSIE-CORE: THE BEST-IN-CLASS DEPLOYMENT ---
TARGET_IP="100.66.159.200"
PORT="42015"

# 1. Download the "Holy Trinity" of APKs
echo "[1/3] Fetching Shizuku, aShell, and Termux..."
curl -L "https://github.com/RikkaApps/Shizuku/releases/download/v13.5.4/shizuku-v13.5.4-release.apk" -o shizuku.apk
curl -L "https://github.com/termux/termux-app/releases/download/v0.118.0/termux-app_v0.118.0+github-debug_arm64-v8a.apk" -o termux.apk
curl -L "https://github.com/pujie92/aShell/releases/download/v1.2.1/aShell-v1.2.1.apk" -o ashell.apk

# 2. Push to Pixel 9 Pro XL
echo "[2/3] Injecting APKs into Hardware..."
adb connect $TARGET_IP:$PORT
adb install -r shizuku.apk
adb install -r termux.apk
adb install -r ashell.apk

# 3. Enable the "Notification Shell"
echo "[3/3] Setting up Notification Triggers..."
# This command creates a persistent notification you can use as a trigger
adb shell "cmd notification post -n 'JOSIE-CORE' -t 'MONOLITH ACTIVE' 'Status: 384 DPI | Multi-Term Ready'"

# Launch the Multiplexer
adb shell "am start -n com.termux/.TermuxActivity"
sleep 2
adb shell "input text 'pkg install tmux -y && tmux'"
adb shell "input keyevent 66"

rm *.apk
echo "[SUCCESS] System is now self-contained on the device."
