#!/bin/bash

SPACE_SIDS=(1 2 3 4 5 6 7 8 9 10)

space=(
  label.font="sketchybar-app-font:Regular:16.0"
  label.padding_right=20
  label.y_offset=-1
  background.color=$BG_SEC_COLR
  script="$PLUGIN_DIR/space.sh"
)

for sid in "${SPACE_SIDS[@]}"
do
  sketchybar --add space space.$sid left \
    --set space.$sid space=$sid \
      icon=$sid \
      ${space[@]}
done

sketchybar --add item space_separator left \
  --set space_separator icon="􀆊" \
    icon.color=$TEAL \
    icon.padding_left=4 \
    label.drawing=off \
    background.drawing=off \
    script="$PLUGIN_DIR/space_windows.sh" \
  --subscribe space_separator space_windows_change
