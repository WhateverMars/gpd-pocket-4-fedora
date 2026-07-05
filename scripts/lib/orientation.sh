#!/bin/bash

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus

MONITOR_CMD="gnome-monitor-config set -L -M eDP-1 -m 1600x2560@143.999 -s 2 -x 0 -y 0 -p"
OSK_KEY="org.gnome.desktop.a11y.applications screen-keyboard-enabled"

apply() {
    case "$1" in
        right-up)  $MONITOR_CMD -t right  ; gsettings set $OSK_KEY false ;;
        normal)    $MONITOR_CMD -t normal ; gsettings set $OSK_KEY true ;;
        bottom-up) $MONITOR_CMD -t flip   ; gsettings set $OSK_KEY true ;;
        left-up)   $MONITOR_CMD -t left   ; gsettings set $OSK_KEY false ;;
        *) echo "Unknown orientation: $1" && exit 1 ;;
    esac
}
