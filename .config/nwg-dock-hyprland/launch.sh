#    ___           __
#   / _ \___  ____/ /__
#  / // / _ \/ __/  '_/
# /____/\___/\__/_/\_\
#

config="$HOME/.config/gtk-3.0/settings.ini"
if [ ! -f $HOME/.config/ml4w/settings/dock-disabled ]; then
    prefer_dark_theme="$(grep 'gtk-application-prefer-dark-theme' "$config" | sed 's/.*\s*=\s*//')"
    if [ $prefer_dark_theme == 0 ]; then
        style="style-light.css"
    else
        style="style-dark.css"
    fi
    nwg-dock-hyprland -hd 20 -f -d -i 32 -w 5 -x -s $style -nolauncher 
else
    echo ":: Dock disabled"
fi
