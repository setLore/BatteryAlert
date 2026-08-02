#!/usr/bin/env bash

BIN_DIR="$HOME/.local/bin"
SERVICE_DIR="$HOME/.config/systemd/user"
BIN_NAME="BatteryAlert"
SERVICE_NAME="BatteryAlert.service"

echo "uninstalling BatteryAlert"

systemctl --user stop "$SERVICE_NAME" 2>/dev/null || true
systemctl --user disable "$SERVICE_NAME" 2>/dev/null || true

rm -f "$BIN_DIR/$BIN_NAME"
rm -f "$SERVICE_DIR/$SERVICE_NAME"

systemctl --user daemon-reload

echo "succesfully uninstalled. bye."

pkill BatteryAlert