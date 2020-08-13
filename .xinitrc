#!/bin/sh

if command -v setxkbmap > /dev/null && \
   command -v xkbcomp > /dev/null && \
   command -v xcape > /dev/null && \
   [ -d ~/setxkbmap ]; then
	setxkbmap -layout "us+symbols(xcape-special)" \
	          -keycodes "evdev+keycodes(xcape-special)" \
	          -option "caps:super,shift:both_shiftlock" -print | \
	          xkbcomp -I"$HOME/setxkbmap" - "${DISPLAY%%.*}" > /dev/null

	xcape -e "Hyper_R=space;Super_L=Escape"
fi

if command -v picom > /dev/null && \
   [ -s ~/picom/picom.conf ]; then
	picom -b --experimental-backends --config ~/picom/picom.conf
fi

if command -v unclutter > /dev/null; then
	unclutter -idle 1 &
fi

case $1 in
dwm)
	if command -v slstatus > /dev/null; then
		slstatus &
	fi
	
	if command -v dwm; then
		exec dwm
	fi
	;;
*)
	if command -v "$1" > /dev/null; then
		exec "$1"
	fi
	;;
esac
