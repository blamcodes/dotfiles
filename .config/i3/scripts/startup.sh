# !/bin/bash
$HOME/.config/polybar/cuts/scripts/pywal.sh ~/.wallpapers
nitrogen $(< "/home/lamb6/.cache/wal/wal" ) --set-scaled --restore 
$HOME/.config/polybar/cuts/launch.sh --cuts
