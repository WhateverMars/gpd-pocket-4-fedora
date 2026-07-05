#!/bin/bash
source "$(dirname "$(readlink -f "$0")")/lib/orientation.sh"

ORIENTATION=$(dbus-send --system --print-reply \
    --dest=net.hadess.SensorProxy \
    /net/hadess/SensorProxy \
    org.freedesktop.DBus.Properties.Get \
    string:net.hadess.SensorProxy \
    string:AccelerometerOrientation \
    | grep -oP 'string "\K[^"]+')

apply "$ORIENTATION"
