#!/bin/bash
# --- JOSIE-CORE: THE PERFECT MONOLITH (V22-FINAL-SILENT) ---
TARGET_IP="100.66.159.200"

# [1/3] SILENT ENVIRONMENT REPAIR
# Suppress all APT and PIP noise
export PIP_DISABLE_PIP_VERSION_CHECK=1
export PIP_ROOT_USER_ACTION=ignore
export PYTHONWARNINGS="ignore"

echo "[SYSTEM] Purging locks and stabilizing Trixie..."
echo "Acquire::ForceIPv4 \"true\";" > /etc/apt/apt.conf.d/99force-ipv4
rm -rf /var/lib/apt/lists/*
killall apt apt-get dpkg 2>/dev/null
apt-get update -qq && apt-get install -qq -y nmap adb git python3-pip > /dev/null 2>&1
pip install --break-system-packages -q firecrawl-py google-generativeai > /dev/null 2>&1

# [2/3] PORT HUNTING & HARDWARE LOCK
# Dynamically find the Wireless Debugging port
ACTIVE_PORT=$(nmap -p 30000-49000 $TARGET_IP --open -Pn | grep "tcp open" -B 1 | grep -oP '\d+(?=/tcp)')
[[ -z "$ACTIVE_PORT" ]] && ACTIVE_PORT="42015"

adb kill-server > /dev/null 2>&1
adb start-server > /dev/null 2>&1
adb connect $TARGET_IP:$ACTIVE_PORT > /dev/null 2>&1

# Enforce Sovereignty
if adb devices | grep -q "$TARGET_IP"; then
    # Force 384 DPI and disable background interference
    adb shell "wm density 384"
    adb shell "pm disable-user --user 0 com.google.android.as" > /dev/null 2>&1
    adb shell "cmd notification post -t 'JOSIE-CORE' 'SYSTEM' 'Monolith Locked at 384 DPI'"
fi

# [3/3] AUTOMATED SYNC
cd ~/Monolith-Core-Global
git add . > /dev/null 2>&1
git commit -m "Perfect Monolith: Zero-Noise Execution" > /dev/null 2>&1
git push origin main --force > /dev/null 2>&1
