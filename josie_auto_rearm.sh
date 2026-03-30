#!/bin/bash
# Scout for the active ADB-TLS port
PORT=$(adb mdns services | grep 'adb-tls-connect' | grep -oE '[0-9]+' | head -n 1)

if [ ! -z "$PORT" ]; then
    # Silent Handshake to local Flask bridge (PID 4428)
    curl -s "http://127.0.0.1:5000/handshake?port=$PORT" > /dev/null
    echo "[SUCCESS] JOSIE-CORE: Hardware Re-Armed on Port $PORT"
fi
