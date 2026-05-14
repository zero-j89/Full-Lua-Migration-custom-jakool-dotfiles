#!/bin/bash
# The exact command you confirmed works
echo -n -e "\x03\x00" | sudo /usr/bin/tee /sys/bus/hid/drivers/razermouse/*/device_mode
notify-send "Razer Naga" "Device Mode Activated" -i input-mouse
