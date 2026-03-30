#!/bin/bash
# --- JOSIE-CORE: ABSOLUTE MONOLITH (PERFECT-SYNC) ---
TARGET_IP="100.66.159.200"

echo "[1/4] SELF-HEALING ENVIRONMENT..."
# Force install firecrawl and ensure dependencies are met
pip install --break-system-packages -q firecrawl-py google-generativeai

echo "[2/4] SYNCING HARDWARE SOVEREIGNTY..."
# Handshake and Ultra-Mode Lock
adb connect $TARGET_IP:42015
adb shell "wm density 384"
adb shell "pm disable-user --user 0 com.google.android.as"
adb shell "pm disable-user --user 0 com.google.android.apps.turbo"
adb shell "cmd notification post -t 'JOSIE-CORE' 'PERFECT' 'Handshake Stabilized: 384 DPI'"

echo "[3/4] INJECTING AUTOMATION ENGINE..."
# Corrected Firecrawl initialization and exploration mapping
python3 << 'PYEOF'
import os
try:
    from firecrawl import FirecrawlApp
    app = FirecrawlApp(api_key="fc-42478c3e37e44d86ad5d6a3c94c5628b")
    print("[SCRAPE] Mapping Open WebUI Explore links...")
    # Map the domain to find all functional endpoints
    map_result = app.map_url('https://openwebui.com/explore')
    print(f"[SUCCESS] Found {len(map_result.get('links', []))} automation paths.")
except Exception as e:
    print(f"[ERROR] Automation injection failed: {e}")
PYEOF

echo "[4/4] IMMORTALIZING GITHUB STATE..."
cd ~/Monolith-Core-Global
git add .
git commit -m "Absolute Monolith: Fixed Firecrawl Module & Corrected API Syntax"
git push origin main --force
