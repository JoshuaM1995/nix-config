#!/usr/bin/env bash

# Check if Spotify is running
if ! pgrep -x "Spotify" > /dev/null; then
  sketchybar -m --set $NAME drawing=off \
                   label.drawing=off \
                   icon.drawing=off \
                   label=""
  exit 0
fi

# Check if Spotify is playing
STATE=$(osascript -e 'tell application "Spotify" to get player state' 2>/dev/null)

if [ "$STATE" != "playing" ]; then
  sketchybar -m --set $NAME drawing=off \
                   label.drawing=off \
                   icon.drawing=off \
                   label=""
  exit 0
fi

# Get track information
TRACK=$(osascript -e 'tell application "Spotify" to get name of current track' 2>/dev/null | tr -d $'\n\r')
ARTIST=$(osascript -e 'tell application "Spotify" to get artist of current track' 2>/dev/null | tr -d $'\n\r')
ALBUM=$(osascript -e 'tell application "Spotify" to get album of current track' 2>/dev/null | tr -d $'\n\r')

# Update sketchybar
sketchybar -m --set $NAME drawing=on \
                 label.drawing=on \
                 icon.drawing=on

if [ -n "$ARTIST" ] && [ -n "$ALBUM" ]; then
  sketchybar -m --set $NAME label="$TRACK - $ARTIST ($ALBUM)"
elif [ -n "$ARTIST" ]; then
  sketchybar -m --set $NAME label="$TRACK - $ARTIST"
elif [ -n "$ALBUM" ]; then
  sketchybar -m --set $NAME label="$TRACK ($ALBUM)"
else
  sketchybar -m --set $NAME label="$TRACK"
fi