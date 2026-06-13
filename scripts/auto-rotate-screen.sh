#!/bin/bash

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

MONITOR_CMD="gnome-monitor-config set -L -M eDP-1 -m 1600x2560@143.999 -s 2 -x 0 -y 0 -p"

monitor-sensor | while read line; do
    if grep -q "orientation changed: right-up" <<< "$line"; then
        $MONITOR_CMD -t right
    elif grep -q "orientation changed: normal" <<< "$line"; then
        $MONITOR_CMD -t normal
    elif grep -q "orientation changed: bottom-up" <<< "$line"; then
        $MONITOR_CMD -t flip
    elif grep -q "orientation changed: left-up" <<< "$line"; then
        $MONITOR_CMD -t left
    fi
done
