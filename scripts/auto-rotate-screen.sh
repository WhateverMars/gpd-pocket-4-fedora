#!/bin/bash

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

MONITOR_CMD="gnome-monitor-config set -L -M eDP-1 -m 1600x2560@143.999 -s 2 -x 0 -y 0 -p"

OSK_KEY="org.gnome.desktop.a11y.applications screen-keyboard-enabled"
OSK_ENABLE="gsettings set $OSK_KEY true"
OSK_DISABLE="gsettings set $OSK_KEY false"

monitor-sensor | while read line; do
    if grep -q "orientation changed: right-up" <<< "$line"; then
        $MONITOR_CMD -t right
        $OSK_DISABLE
    elif grep -q "orientation changed: normal" <<< "$line"; then
        $MONITOR_CMD -t normal
        $OSK_ENABLE
    elif grep -q "orientation changed: bottom-up" <<< "$line"; then
        $MONITOR_CMD -t flip
        $OSK_ENABLE
    elif grep -q "orientation changed: left-up" <<< "$line"; then
        $MONITOR_CMD -t left
        $OSK_DISABLE
    fi
done
