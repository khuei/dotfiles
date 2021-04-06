#!/bin/sh

[ "$(command -v picom)" ] && [ -s ~/picom/picom.conf ] && \
	picom -b --experimental-backends --config ~/picom/picom.conf

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
