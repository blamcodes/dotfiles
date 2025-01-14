#!/bin/bash
#
# This file can contain commands that will be executed (as root) at the end of
# EndeavourOS install (in online mode only) on the target system.
#
# NOTE! This is an advanced feature, so you need to know exactly
# what you are doing. Otherwise bad things can happen...
# Sound knowledge of bash language and linux commands is required
# for a meaningful customization.
#
# If you add commands to this file, start the whole install process fresh
# with terminal command 'eos-welcome' after saving this file.
#
# Tip: save your customized commands into a file on an internet server
# and fetch that file with command:
#
#     wget -O ~/user_commands.bash "URL-referring-the-file"
#
# Here you may customize the installed system in several ways.
#
# Ideas for customization:
#   - install packages
#   - remove packages
#   - enable or disable system services
#   - writing dotfiles under $HOME
#   - etc.
#
# Example commands:
#     pacman -S --noconfirm --needed gufw geany chromium
#     pacman -Rsn --noconfirm xed
#     systemctl enable ufw
#
# There are some limitations to the commands:
#   - The 'pacman' commands mentioned above require option '--noconfirm',
#     otherwise the install process may hang because pacman waits for a
#     confirmation!
#   - Installing packages with 'yay' does not work because yay may not
#     be run as root.
#     The 'makepkg' command suffers from the same limitation.
#     This essentially blocks installing AUR packages here.
#
# Tip: if you write new files into the home directory of the new user,
# make sure to properly set the file permissions too.
#
#----------------------------------------------------------------------------------
#
# Now *you* can add your commands into function _PostInstallCommands below.
#
#----------------------------------------------------------------------------------

_PostInstallCommands() {
    ## Add your "late-install" commands here.
    ## This is executed as root near the end of calamares execution.

    local -r username="$1"              # new user you created for the target

    ## Now your commands. Some examples:
    #
    # echo "## Hello world!"           >> /home/$username/.bashrc
    # echo "export FUNCNEST=100"       >> /home/$username/.bashrc
    # echo "alias pacdiff=eos-pacdiff" >> /home/$username/.bashrc
    # chmod $username:$username           /home/$username/.bashrc
    #
    # pacman -S --noconfirm --needed geany chromium libreoffice-fresh
    # ...
    echo "## Changing default shell of user..."
    grep $username /etc/passwd
    usermod --shell /bin/zsh $username
    grep $username /etc/passwd

    echo "## Setting i3 like bindings for hyprland..."
    cd /home/$username

    sed '/s/\$menu = wofi --show drun/\$menu = rofi -show drun/' .config/hypr/hyprland.conf
    sed '/s/bind = \$mainMod, R, exec/bind = \$mainMod, D, exec/' .config/hypr/hyprland.conf
    sed '/s/bind = \$mainMod, Q, exec/bind = \$mainMod, RETURN, exec/' .config/hypr/hyprland.conf
    sed '/s/bind = \$mainMod, C, killactive/bind = \$mainMod SHIFT, Q, killactive/' .config/hypr/hyprland.conf
    sed '/s/bind = \$mainMod, left, movefocus/bind = \$mainMod, h, movefocus/' .config/hypr/hyprland.conf
    sed '/s/bind = \$mainMod, right, movefocus/bind = \$mainMod, l, movefocus/' .config/hypr/hyprland.conf
    sed '/s/bind = \$mainMod, up, movefocus/bind = \$mainMod, k, movefocus/' .config/hypr/hyprland.conf
    sed '/s/bind = \$mainMod, down, movefocus/bind = \$mainMod, j, movefocus/' .config/hypr/hyprland.conf
    sed '/s/disable_hyprland_logo = false/disable_hyprland_logo = true/' .config/hypr/hyprland.conf

    echo "## Docker adding user to docker..."
    group add docker
    usermod -aG docker $username
    newgrp docker

    echo "## Starting docker socket..."
    systemctl enable docker.socket
    systemctl start docker.socket
}

## Execute the commands if the parameter list is valid:

case "$1" in
    --iso-conf* | online | offline | community) ;;   # no more supported here
    *) _PostInstallCommands "$1" ;;
esac
