#!/bin/bash
cd ~/Monolith-Core-Global
# Only push if there are changes to avoid clutter
if [[ $(git status --porcelain) ]]; then
    git add .
    git commit -m "JOSIE-CORE: Autonomous System Update [GREEN]"
    # Pushes silently via HTTPS
    gh repo push --force
    echo "[SUCCESS] Josie: Cloud Sync Complete."
fi
