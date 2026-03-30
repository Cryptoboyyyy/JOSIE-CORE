import requests
import subprocess
import time

# Josie's internal scouting logic
BRIDGE_URL = "http://127.0.0.1:5000/handshake"
TARGET_IP = "100.66.159.200"

def scout_for_port():
    print("[+] JOSIE-CORE: Initiating Ghost Scan...")
    # Using local mDNS to find the random Wireless Debugging port
    try:
        result = subprocess.check_output("adb mdns services | grep 'adb-tls-connect'", shell=True).decode()
        # Extract port logic
        new_port = result.split()[-1].split(':')[-1]
        return new_port
    except:
        return None

def notify_bridge(port):
    try:
        response = requests.get(f"{BRIDGE_URL}?port={port}")
        print(f"[!] Josie Response: {response.text}")
    except Exception as e:
        print(f"[-] Bridge Communication Error: {e}")

if __name__ == "__main__":
    while True:
        discovered_port = scout_for_port()
        if discovered_port:
            notify_bridge(discovered_port)
        time.sleep(60) # Scan every minute
