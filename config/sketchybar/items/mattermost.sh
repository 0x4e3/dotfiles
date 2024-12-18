#!/usr/bin/env bash

mattermost=(
  update_freq=10
  script="$PLUGIN_DIR/mattermost.sh"
  background.color=$BG_SEC_COLR
  icon.font="sketchybar-app-font:Regular:16.0"
  click_script="open -a 'Mattermost'"
)

sketchybar -m --add item mattermost right \
  --set mattermost "${mattermost[@]}" \
  --subscribe mattermost system_woke

