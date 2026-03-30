#!/bin/bash
# Check if Josie is green
STATUS=$(systemctl is-active josie-bridge.service)

if [ "$STATUS" == "active" ]; then
    echo "[+] Josie: System Status Green. Executing Cloud Sync..."
    git add .
    git commit -m "JOSIE-CORE: Autopilot Sync [STATUS: ACTIVE]"
    # Using the verified gh CLI for non-interactive push
    gh repo sync
else
    echo "[!] Josie: System Red. Attempting Self-Repair..."
    systemctl restart josie-bridge.service
fi
