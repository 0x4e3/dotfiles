clock=(
  update_freq=1
  icon.color=$MAUVE
  icon=$CALENDAR_ICON
  background.color=$BG_SEC_COLR
  script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item clock right \
  --set clock "${clock[@]}"
