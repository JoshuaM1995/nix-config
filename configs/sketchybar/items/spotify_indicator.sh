#!/bin/bash

sketchybar -m --add event spotify_change "com.spotify.client.PlaybackStateChanged" \
           --add item spotify_indicator center \
           --set spotify_indicator background.color=$ACCENT_COLOR  \
           --set spotify_indicator background.height=21 \
           --set spotify_indicator background.padding_left=8 \
           --set spotify_indicator background.padding_right=8 \
           --set spotify_indicator icon=􀑪 \
           --set spotify_indicator icon.color=$ITEM_BG_COLOR \
           --set spotify_indicator icon.padding_left=5 \
           --set spotify_indicator icon.padding_right=3 \
           --set spotify_indicator label.color=$ITEM_BG_COLOR \
           --set spotify_indicator label.drawing=on \
           --set spotify_indicator label.padding_right=5 \
           --set spotify_indicator update_freq=2 \
           --set spotify_indicator script="$PLUGIN_DIR/spotify_indicator.sh" \
           --set spotify_indicator click_script="$PLUGIN_DIR/spotify_click.sh" \
           --subscribe spotify_indicator spotify_change \
           --update spotify_indicator