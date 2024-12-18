#!/usr/bin/env sh

source $CONFIG_DIR/colors.sh

ICON=$($CONFIG_DIR/plugins/icon_map_fn.sh "Telegram")
STATUS_LABEL=$(lsappinfo info -only StatusLabel "Telegram")

if [[ $STATUS_LABEL =~ \"label\"=\"([^\"]*)\" ]]; then
  LABEL="${BASH_REMATCH[1]}"

  if [[ $LABEL == "" ]]; then
    LABEL="-"
    ICON_COLOR=$WHITE
  elif [[ $LABEL == "•" ]]; then
    ICON_COLOR=$YELLOW
  elif [[ $LABEL =~ ^[0-9]+$ ]]; then
    ICON_COLOR=$RED
  else
    exit 0
  fi
else
  exit 0
fi

sketchybar --set $NAME label="$LABEL" icon="$ICON" icon.color=$ICON_COLOR

