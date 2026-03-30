#!/bin/bash
# --- JOSIE-CORE: AUTONOMOUS GHOST-SHELL BRIDGE ---
# Target: Your Phone's Internal VPN IP (Assigned by your GCP VPN)
PHONE_IP="10.10.10.1" 
PORT="5555"

echo "[STARTING] JOSIE-CORE Autonomous Bridge..."

while true; do
    # 1. Check if the device is already 'online' in ADB
    CHECK_DEVICE=$(adb devices | grep "$PHONE_IP:$PORT")

    if [[ -z "$CHECK_DEVICE" ]]; then
        echo "[RECONNECT] Link lost. Attempting Ghost-Shell handshake..."
        
        # 2. Attempt to connect
        adb connect "$PHONE_IP:$PORT"
        
        # 3. Verify success
        sleep 2
        STATUS=$(adb get-state 2>&1)
        if [[ "$STATUS" == "device" ]]; then
            echo "[SUCCESS] Ghost-Shell persistent. Link active."
            # Trigger your automation start here
        fi
    fi

    # 4. Wait 30 seconds before next heartbeat check
    sleep 30
done

