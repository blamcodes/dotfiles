#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/cuts"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  # for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  #   MONITOR=$m polybar -q top -c "$DIR"/config.ini &
  # done
  MONITOR="DP-3-8" polybar -q top -c "$DIR"/config.ini &
  MONITOR="eDP-1" polybar -q alt -c "$DIR"/config.ini &
  MONITOR="DP-3-1" polybar -q alt -c "$DIR"/config.ini &
else
  polybar -q top -c "$DIR"/config.ini &
fi

# # Launch the bar
# polybar -q top -c "$DIR"/config.ini &
