#!/bin/bash
# __  ______   ____ 
# \ \/ /  _ \ / ___|
#  \  /| | | | |  _ 
#  /  \| |_| | |_| |
# /_/\_\____/ \____|
#                   

sleep 1

# kill all possible running xdg-desktop-portals
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-gnome
killall -e xdg-desktop-portal-kde
killall -e xdg-desktop-portal-lxqt
killall -e xdg-desktop-portal-wlr
killall -e xdg-desktop-portal-gtk
killall -e xdg-desktop-portal

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland
systemctl --user stop pipewire 
systemctl --user stop wireplumber 
systemctl --user stop xdg-desktop-portal 
systemctl --user stop xdg-desktop-portal-hyprland

sleep 1

# start xdg-desktop-portal-hyprland
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2

# start xdg-desktop-portal-gtk
if [ -f /usr/lib/xdg-desktop-portal-gtk ] ;then
    /usr/lib/xdg-desktop-portal-gtk &
    sleep 1
fi

# start xdg-desktop-portal
/usr/lib/xdg-desktop-portal &
sleep 1

systemctl --user start pipewire 
systemctl --user start wireplumber 
systemctl --user start xdg-desktop-portal 
systemctl --user start xdg-desktop-portal-hyprland
