#!/bin/bash

volume=(
  icon.color=$GREEN
  background.color=$BG_SEC_COLR
  script="$PLUGIN_DIR/volume.sh"
)

sketchybar --add item sound right \
 --set sound "${volume[@]}" \
 --subscribe sound volume_change 
