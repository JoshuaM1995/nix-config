#!/bin/bash

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        background.color=0xff001E2E \
        background.height=20 \
        background.drawing=off \
        padding_left=2 \
        padding_right=2 \
        label.padding_left=2 \
        label.padding_right=2 \
        label="$sid" \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done