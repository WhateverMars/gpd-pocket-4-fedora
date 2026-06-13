#!/bin/bash

export DISPLAY=:0

# Wait a moment for devices to initialize
sleep 2

# Find the Logitech MX Master 3S device ID
MOUSE_ID=$(xinput list | grep "Logitech MX Master 3S" | grep -oP 'id=\K\d+')

if [ -n "$MOUSE_ID" ]; then
    xinput set-prop $MOUSE_ID "libinput Accel Speed" 0.45
fi
