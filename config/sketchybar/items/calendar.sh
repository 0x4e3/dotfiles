clock=(
  update_freq=1
  icon.font="$ICON_FONT:Regular:20.0"
  icon.color=$MAUVE
  background.color=$BG_SEC_COLR
  script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item clock right \
  --set clock "${clock[@]}"
