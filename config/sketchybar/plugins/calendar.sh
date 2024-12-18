#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

source "$CONFIG_DIR/icons.sh"

sketchybar --set "$NAME" label="$(date '+%H:%M:%S')" 
