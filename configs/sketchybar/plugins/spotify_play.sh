#!/usr/bin/env bash

# Check if Spotify is running
if ! pgrep -x "Spotify" > /dev/null; then
  sketchybar -m --set $NAME icon=􀊄 \
                   drawing=on \
                   icon.drawing=on
  exit 0
fi

# Get current player state
STATE=$(osascript -e 'tell application "Spotify" to get player state' 2>/dev/null)

if [ "$STATE" == "playing" ]; then
  sketchybar -m --set $NAME icon=􀊆 \
                   drawing=on \
                   icon.drawing=on
else
  sketchybar -m --set $NAME icon=􀊄 \
                   drawing=on \
                   icon.drawing=on
fi

