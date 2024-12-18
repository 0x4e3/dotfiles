#!/usr/bin/env bash

battery=(
  update_freq=120
  background.color=$BG_SEC_COLR
  script="$PLUGIN_DIR/battery.sh"
)

battery_details=(
	background.corner_radius=12
	background.padding_left=5
	background.padding_right=10
	icon.background.height=2
	icon.background.y_offset=-12
)

sketchybar -m --add item battery right \
  --set battery "${battery[@]}" \
  --subscribe battery mouse.entered \
    mouse.exited \
    mouse.exited.global \
    power_source_change \
    system_woke
  # --add item battery.details popup.battery \
  # --set battery.details "${battery_details[@]}" 

