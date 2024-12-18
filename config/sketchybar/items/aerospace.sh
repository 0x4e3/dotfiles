#!/bin/bash

sketchybar --add event aerospace_workspace_change

space=(
  # background.color=$BG_PRI_COLR
  # background.corner_radius=5
  # background.height=20
  # background.drawing=off
  label.color=$DARK_WHITE
)

for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item space.$sid left \
    --subscribe space.$sid aerospace_workspace_change \
    --set space.$sid \
      ${space[@]} \
      label="$sid" \
      click_script="aerospace workspace $sid" \
      script="$PLUGIN_DIR/aerospace.sh $sid"
done
