#!/bin/bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME label.color=$WHITE
else
  sketchybar --set $NAME label.color=$DARK_WHITE 
fi
