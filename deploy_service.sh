#!/bin/bash
adb connect 100.66.159.200:39083
adb shell "wm density 411; settings put secure display_density_forced 411"
adb shell "cmd notification post -t 'MONOLITH-CORE' 'Status' 'System Re-Calibrated'"
