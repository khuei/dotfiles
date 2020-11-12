#!/bin/sh

[ "$(command -v setxkbmap)" ] && [ "$(command -v xkbcomp)" ] && \
[ "$(command -v xcape)" ] && [ -d ~/setxkbmap ] && {
	setxkbmap -layout "us+symbols(xcape-special)" \
	          -keycodes "evdev+keycodes(xcape-special)" \
	          -option "caps:super,shift:both_shiftlock" \
	          -print | xkbcomp -I"$HOME/setxkbmap" - "${DISPLAY%%.*}" 2>/dev/null

	xcape -e "Hyper_R=space;Super_L=Escape"
}

[ "$(command -v picom)" ] && [ -s ~/picom/picom.conf ] && \
	wp && picom -b --experimental-backends --config ~/picom/picom.conf

[ "$(command -v unclutter)" ] && unclutter -idle 1 &

case "$1" in
dwm)
	[ "$(command -v slstatus)" ] && slstatus &
	[ "$(command -v dwm)" ] && exec dwm
	;;
*)
	[ "$(command -v "$1")" ] && exec "$1"
	;;
esac
