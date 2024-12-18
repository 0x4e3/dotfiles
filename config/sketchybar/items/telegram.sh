#!/usr/bin/env bash

telegram=(
  update_freq=30
  script="$PLUGIN_DIR/telegram.sh"
  background.color=$BG_SEC_COLR
  icon.font="sketchybar-app-font:Regular:16.0"
  click_script="open -a 'Telegram'"
)

sketchybar -m --add item telegram right \
  --set telegram "${telegram[@]}" \
  --subscribe telegram system_woke

