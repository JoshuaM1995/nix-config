#!/usr/bin/env bash

# Check if Spotify is running
if ! pgrep -x "Spotify" > /dev/null; then
  # Open Spotify and start playing
  open -a Spotify
  sleep 1
  osascript -e 'tell application "Spotify" to play'
  exit 0
fi

# Get current player state
STATE=$(osascript -e 'tell application "Spotify" to get player state' 2>/dev/null)

if [ "$STATE" != "playing" ]; then
  # Resume/play
  osascript -e 'tell application "Spotify" to play'
else
  # Pause if playing
  osascript -e 'tell application "Spotify" to pause'
fi

