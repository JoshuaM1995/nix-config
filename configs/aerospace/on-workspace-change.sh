#!/usr/bin/env bash

sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE

if [ "$AEROSPACE_FOCUSED_WORKSPACE" = "B" ]; then
    aerospace layout accordion vertical
    sleep 0.1
elif [ "$AEROSPACE_FOCUSED_WORKSPACE" = "M" ]; then
    aerospace layout tiles horizontal
    sleep 0.2
    
    if aerospace list-windows --workspace M | grep -q "net.whatsapp.WhatsApp" && \
       aerospace list-windows --workspace M | grep -q "com.mimestream.Mimestream"; then
        aerospace focus-window --app-id com.mimestream.Mimestream 2>/dev/null && \
        aerospace move right 2>/dev/null
        sleep 0.15
        aerospace focus-window --app-id net.whatsapp.WhatsApp 2>/dev/null
        sleep 0.1
        aerospace resize width -50 2>/dev/null || true
    fi
fi

