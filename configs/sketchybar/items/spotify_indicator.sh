#!/bin/bash

sketchybar -m --add event spotify_change "com.spotify.client.PlaybackStateChanged" \
           --add item spotify_indicator center \
           --set spotify_indicator background.color=$ACCENT_COLOR  \
           --set spotify_indicator background.height=21 \
           --set spotify_indicator background.padding_left=7 \
           --set spotify_indicator background.padding_right=7 \
           --set spotify_indicator label.color=$ITEM_BG_COLOR \
           --set spotify_indicator label.drawing=on \
           --set spotify_indicator update_freq=2 \
           --set spotify_indicator script="$PLUGIN_DIR/spotify_indicator.sh" \
           --set spotify_indicator click_script="osascript -e 'tell application \"Spotify\" to pause'" \
           --subscribe spotify_indicator spotify_change \
           --update spotify_indicator