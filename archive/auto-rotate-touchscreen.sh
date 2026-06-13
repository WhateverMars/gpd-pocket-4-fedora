#!/bin/bash

export DISPLAY=:0

TOUCHSCREEN_ID=13

# Transformation matrices for each orientation
LANDSCAPE="1 0 0 0 1 0 0 0 1"
PORTRAIT_LEFT="0 1 0 -1 0 1 0 0 1"
PORTRAIT_RIGHT="0 -1 1 1 0 0 0 0 1"
INVERTED="-1 0 1 0 -1 1 0 0 1"

monitor-sensor | while read line; do
    if echo "$line" | grep -q "orientation changed: right-up"; then
        xinput set-prop $TOUCHSCREEN_ID "Coordinate Transformation Matrix" $LANDSCAPE
    elif echo "$line" | grep -q "orientation changed: normal"; then
        xinput set-prop $TOUCHSCREEN_ID "Coordinate Transformation Matrix" $PORTRAIT_RIGHT
    elif echo "$line" | grep -q "orientation changed: bottom-up"; then
        xinput set-prop $TOUCHSCREEN_ID "Coordinate Transformation Matrix" $PORTRAIT_LEFT
    elif echo "$line" | grep -q "orientation changed: left-up"; then
        xinput set-prop $TOUCHSCREEN_ID "Coordinate Transformation Matrix" $INVERTED
    fi
done
