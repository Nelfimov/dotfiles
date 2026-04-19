#!/bin/bash

# For ergohaven K:03 RuEn mode
curl -fsSLO https://github.com/VlaDi4eKK/qmk-hid-host/releases/download/latest/QMK-HID-Host-macos-app.zip

unzip QMK-HID-Host-macos-app.zip
rm QMK-HID-Host-macos-app.zip

cp 'QMK HID Host.app' ~/Applications/
