#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/cuts"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# We will use xrandr to determine which bars will appear on
# which monitor.
if type "xrandr"; then
  active_monitors=$(xrandr --listactivemonitors | grep ":" | cut -d" " -f6)
  for m in $active_monitors; do
    output=$(xrandr --query | grep $m | cut -d" " -f1-4)

    # Cut the output string matching the output to determine if
    # the monitor is primary or not and assign the appropriate
    # bar (bar/top or bar/alt) to it.
    is_primary=$(echo $output | cut -d" " -f3)
    display=$(echo $output | cut -d" " -f1)
    if [[ $is_primary = "primary" ]]; then
      MONITOR=$display polybar -q top -c "$DIR"/config.ini &
    else
      MONITOR=$display polybar -q alt -c "$DIR"/config.ini &
    fi
  done
fi
