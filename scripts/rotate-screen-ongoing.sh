#!/bin/bash
source "$(dirname "$(readlink -f "$0")")/lib/orientation.sh"

monitor-sensor | while read line; do
    ORIENTATION=$(grep -oP "orientation changed: \K\S+" <<< "$line")
    [ -n "$ORIENTATION" ] && apply "$ORIENTATION"
done
