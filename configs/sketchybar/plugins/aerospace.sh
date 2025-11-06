#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on \
                              label.color=0xff2BEEE3 \
                              label.font="SF Pro:Bold:13.0"
else
    sketchybar --set $NAME background.drawing=off \
                              label.color=0xffffffff \
                              label.font="SF Pro:Regular:13.0"
fi