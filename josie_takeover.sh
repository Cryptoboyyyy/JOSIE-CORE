#!/bin/bash
# 1. Scout for new device ports
PORT=$(adb mdns services | grep 'adb-tls-connect' | awk '{print $NF}' | cut -d':' -f2)

if [ ! -z "$PORT" ]; then
    echo "[+] Josie: New Port Detected: $PORT"
    # 2. Trigger the internal handshake
    curl "http://127.0.0.1:5000/handshake?port=$PORT"
    
    # 3. Auto-commit the success to GitHub
    git add .
    git commit -m "Josie: Auto-Sync Success on Port $PORT"
    gh repo push
    echo "[SUCCESS] JOSIE-CORE Synchronized."
else
    echo "[-] Josie: No new targets found."
fi
