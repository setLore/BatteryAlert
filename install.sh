#!/usr/bin/env bash
set -e

BIN_DIR="$HOME/.local/bin"
SERVICE_DIR="$HOME/.config/systemd/user"
BIN_NAME="BatteryAlert"
SERVICE_NAME="BatteryAlert.service"

if [ ! -f "./$BIN_NAME" ]; then
    echo "compiled binary not found, attempting build..."

    if ! command -v pyinstaller &> /dev/null; then
        echo "pyinstaller not found, run \`pip install pyinstaller\`"
        exit 1
    fi

    pyinstaller --onefile --noconsole BatteryAlert.py -n "$BIN_NAME"
    cp "./dist/$BIN_NAME" "./$BIN_NAME"
fi



echo "installing BatteryAlert..."

mkdir -p "$BIN_DIR"
mkdir -p "$SERVICE_DIR"

systemctl --user stop "$SERVICE_NAME" 2>/dev/null || true
systemctl --user disable "$SERVICE_NAME" 2>/dev/null || true
systemctl --user daemon-reload
rm -f "$BIN_DIR/$BIN_NAME"
rm -f "$SERVICE_DIR/$SERVICE_NAME"

cp "./$BIN_NAME" "$BIN_DIR/$BIN_NAME"
chmod +x "$BIN_DIR/$BIN_NAME"
cp "./BatteryAlert.service" "$SERVICE_DIR/BatteryAlert.service"


systemctl --user daemon-reload
systemctl --user enable --now BatteryAlert.service

echo "successfully installed. hi."
pkill BatteryAlert