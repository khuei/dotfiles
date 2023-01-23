#!/bin/sh

{
	[ "$(command -v picom)" ] && picom -b

	[ "$(command -v unclutter)" ] && unclutter -idle 1 &

	[ "$(command -v nm-applet)" ] && {
		nm-applet &
		[ -z "${DBUS_SESSION_BUS_ADDRESS}" ] &&
			eval "$(dbus-launch --sh-syntax --exit-with-session)"
	}

	[ "$(command -v blueman-applet)" ] && {
		blueman-applet &
	}

	export "$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)"
} >/dev/null &

case "$1" in
dwm)
	[ "$(command -v dwm)" ] && exec dwm
	;;
*)
	[ "$(command -v "$1")" ] && exec "$1"
	;;
esac
