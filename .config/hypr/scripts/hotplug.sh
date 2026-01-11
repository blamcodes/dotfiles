#!/bin/bash
# Hyprland Docking Station Hotplug Handler
# Detects connected monitors and switches configurations automatically

# Configuration paths
HYPR_CONF_DIR="$HOME/.config/hypr/conf"
MONITOR_CONF="$HYPR_CONF_DIR/monitor.conf"

# Get current connected displays
get_connected_displays() {
    xrandr --query | grep " connected" | wc -l
}

# Check for specific monitor patterns to identify configurations
detect_setup() {
    local connected_count=$(get_connected_displays)
    local external_displays=$((connected_count - 1))  # Subtract built-in display
    
    # Check for iron-sight setup (4 monitors total = 3 external)
    if [ $external_displays -ge 3 ]; then
        # Verify iron-sight specific monitors are connected
        if xrandr --query | grep -q "Microstep MSI MP273U" && 
           xrandr --query | grep -q "LG Electronics LG HDR 4K"; then
            echo "iron-sight"
            return
        fi
    fi
    
    # Check for home setup (3+ monitors)
    if [ $external_displays -ge 2 ]; then
        echo "home"
        return
    fi
    
    # Check for single external monitor
    if [ $external_displays -eq 1 ]; then
        echo "default"
        return
    fi
    
    # Laptop only
    echo "1920x1200"
}

# Switch monitor configuration
switch_monitors() {
    local setup="$1"
    local target_config="$HYPR_CONF_DIR/monitors/$setup.conf"
    
    if [ -f "$target_config" ]; then
        echo "source = ~/.config/hypr/conf/monitors/$setup.conf" > "$MONITOR_CONF"
        hyprctl reload
        echo "Switched to $setup configuration"
        
        # Handle audio switching
        switch_audio "$setup"
    else
        echo "Configuration $setup.conf not found"
    fi
}

# Switch audio configuration
switch_audio() {
    local setup="$1"
    
    # Suspend all HDMI outputs first
    pactl list sinks short | grep HDMI | while read -r sink_info; do
        sink_name=$(echo "$sink_info" | cut -f2)
        pactl suspend-sink "$sink_name" 1
    done
    
    if [ "$setup" = "1920x1200" ]; then
        # Laptop only - use headphones/speakers
        pactl set-default-sink "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink"
    else
        # Docked - you can set preferred external audio here
        # For now, keeping headphones as default but unsuspending HDMI options
        pactl list sinks short | grep HDMI | head -1 | while read -r sink_info; do
            sink_name=$(echo "$sink_info" | cut -f2)
            pactl suspend-sink "$sink_name" 0
        done
    fi
}

# Main execution
if [ "$1" = "--detect" ]; then
    # Detect and switch automatically
    current_setup=$(detect_setup)
    echo "Detected setup: $current_setup"
    switch_monitors "$current_setup"
elif [ "$1" = "--manual" ] && [ -n "$2" ]; then
    # Manual switch to specific configuration
    switch_monitors "$2"
else
    echo "Usage:"
    echo "  $0 --detect              # Auto-detect and switch"
    echo "  $0 --manual <config>     # Switch to specific config"
    echo ""
    echo "Available configurations:"
    ls "$HYPR_CONF_DIR/monitors/"*.conf | sed 's/.*\///' | sed 's/\.conf$//' | sed 's/^/  /'
fi