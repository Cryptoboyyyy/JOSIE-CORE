#!/bin/bash
# --- JOSIE-CORE: THE APP FACTORY ---
TARGET_IP="100.66.159.200"

# [1] Setup Build Environment
sudo apt update && sudo apt install -y openjdk-17-jdk-headless git wget unzip -qq
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# [2] Clone the Source (Example: aShell for system control)
mkdir -p ~/JOSIE-BUILD && cd ~/JOSIE-BUILD
git clone https://github.com/sunilpaulmathew/ashell.git
cd ashell

# [3] Build the Monolith (Gradle)
chmod +x gradlew
./gradlew assembleRelease --quiet

# [4] Push "Green" to Hardware
adb connect $TARGET_IP:42015
adb install -r app/build/outputs/apk/release/aShell-release.apk

adb shell "cmd notification post -t 'JOSIE-CORE' 'BUILD COMPLETE' 'New Monolith Component Installed'"
