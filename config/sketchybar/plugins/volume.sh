#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

source "$CONFIG_DIR/icons.sh"

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
    [9][0-9]|100) ICON=${VOLUME_100}
    ;;
    [6-8][0-9]) ICON=${VOLUME_66}
    ;;
    [3-5][0-9]) ICON=${VOLUME_33}
    ;;
    [1-9]|[0-2][0-9]) ICON=${VOLUME_10}
    ;;
    *) ICON=${VOLUME_0}
  esac

  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
fi
