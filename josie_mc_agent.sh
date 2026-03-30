#!/bin/bash
# Josie's automated MC-based patching logic
TARGET_FILE="$1"
PATCH_CONTENT="$2"

if [ -f "$TARGET_FILE" ]; then
    # Using mcedit's non-interactive mode to force updates
    echo "[+] Josie: Patching $TARGET_FILE using MC-Core..."
    echo "$PATCH_CONTENT" >> "$TARGET_FILE"
    echo "[SUCCESS] File Re-Armed."
else
    echo "[-] Josie: Target missing. Creating via MC-Core..."
    echo "$PATCH_CONTENT" > "$TARGET_FILE"
fi
