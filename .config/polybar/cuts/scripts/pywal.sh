#!/usr/bin/env bash

# Color files
PFILE="$HOME/.config/polybar/cuts/colors.ini"
RFILE="$HOME/.config/polybar/cuts/scripts/rofi/colors.rasi"
WFILE="$HOME/.cache/wal/colors.sh"

# Get colors
pywal_get() {
	wal -n -i "$@" -s -t
}

nitrogen_set() {
  nitrogen $(< "/home/lamb6/.cache/wal/wal" ) --set-scaled
}

# Change colors
change_color() {
	# polybar
	sed -i -e "s/background = #.*/background = #${BG}/g" $PFILE
	sed -i -e "s/background-alt = #.*/background-alt = #${BGA}/g" $PFILE
	sed -i -e "s/foreground = #.*/foreground = #${FG}/g" $PFILE
	sed -i -e "s/foreground-alt = #.*/foreground-alt = #${FGA}/g" $PFILE
	sed -i -e "s/primary = #.*/primary = ${BG}/g" $PFILE
  sed -i -e "s/red = #.*/red = ${RED}/g" $PFILE
  sed -i -e "s/green = #.*/green = ${GREEN}/g" $PFILE
  sed -i -e "s/yellow = #.*/yellow = ${YELLOW}/g" $PFILE
	sed -i -e "s/color1 = .*/color1 = ${COLOR1}/g" $PFILE
	sed -i -e "s/color2 = .*/color2 = ${COLOR2}/g" $PFILE
	sed -i -e "s/color3 = .*/color3 = ${COLOR3}/g" $PFILE
	sed -i -e "s/color4 = .*/color4 = ${COLOR4}/g" $PFILE
	sed -i -e "s/color5 = .*/color5 = ${COLOR5}/g" $PFILE
	sed -i -e "s/color6 = .*/color6 = ${COLOR6}/g" $PFILE
	sed -i -e "s/color7 = .*/color7 = ${COLOR7}/g" $PFILE
	sed -i -e "s/color8 = .*/color8 = ${COLOR8}/g" $PFILE
	sed -i -e "s/color9 = .*/color9 = ${COLOR9}/g" $PFILE
	sed -i -e "s/color10 = .*/color10 = ${COLOR10}/g" $PFILE
	sed -i -e "s/color11 = .*/color11 = ${COLOR11}/g" $PFILE
	sed -i -e "s/color12 = .*/color12 = ${COLOR12}/g" $PFILE
	sed -i -e "s/color13 = .*/color13 = ${COLOR13}/g" $PFILE
	sed -i -e "s/color14 = .*/color14 = ${COLOR14}/g" $PFILE
	sed -i -e "s/color15 = .*/color15 = ${COLOR15}/g" $PFILE
	
	# rofi
	cat > $RFILE <<- EOF
	/* colors */

	* {
	  al:   #00000000;
	  bg:   #${BG}BF;
	  bga:  #${BGA}1A;
	  fg:   #${FGA}FF;
	  ac:   ${GREEN}FF;
	  se:   ${COLOR15}1A;
	}
	EOF
	
	# polybar-msg cmd restart
}

# Main
if [[ -x "`which wal`" ]]; then
	if [[ "$1" ]]; then
		pywal_get "$1"


		# Source the pywal color file
		if [[ -e "$WFILE" ]]; then
			. "$WFILE"
		else
			echo 'Color file does not exist, exiting...'
			exit 1
		fi
		BGC=`printf "%s\n" "$background"`
		BG=${BGC:1}
		BGAC=`printf "%s\n" "$background"`
		BGA=${BGAC:1}
		FGC=`printf "%s\n" "$foreground"`
		FG=${FGC:1}
		FGAC=`printf "%s\n" "$color7"`
		FGA=${FGAC:1}
		COLOR1=`printf "%s\n" "$color1"`
		COLOR2=`printf "%s\n" "$color2"`
		COLOR3=`printf "%s\n" "$color3"`
		COLOR4=`printf "%s\n" "$color4"`
		COLOR5=`printf "%s\n" "$color5"`
		COLOR5=`printf "%s\n" "$color5"`
		COLOR6=`printf "%s\n" "$color6"`
		YELLOW=`printf "%s\n" "$color6"`
		COLOR7=`printf "%s\n" "$color7"`
		COLOR8=`printf "%s\n" "$color8"`
		RED=`printf "%s\n" "$color8"`
		COLOR9=`printf "%s\n" "$color9"`
		COLOR10=`printf "%s\n" "$color10"`
		COLOR11=`printf "%s\n" "$color11"`
		GREEN=`printf "%s\n" "$color5"`
		COLOR12=`printf "%s\n" "$color12"`
		COLOR13=`printf "%s\n" "$color13"`
		COLOR14=`printf "%s\n" "$color14"`
		COLOR15=`printf "%s\n" "$color15"`

		change_color
    nitrogen_set 
	else echo -e "[!] Please enter the path to wallpaper. \n"
		echo "Usage : ./pywal.sh path/to/image"
	fi
else
	echo "[!] 'pywal' is not installed."
fi
