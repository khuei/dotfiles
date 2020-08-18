#!/usr/bin/env zsh

{
	[ "$(command -v hash)" ] || return 1

	local CODE=~/code
	local CONSOLEFONT=/usr/share/consolefonts
	local FONT=/usr/share/fonts
	local LINUX=/usr/src/linux
	local LOG=/var/log
	local OVERLAY=/var/db/repos
	local PORTAGE=/etc/portage

	[ -d "$CODE" ] && hash -d code="$CODE"
	[ -d "$CONSOLEFONT" ] && hash -d consolefont="$CONSOLEFONT"
	[ -d "$FONT" ] && hash -d font="$FONT"
	[ -d "$LINUX" ] && hash -d linux="$LINUX"
	[ -d "$LOG" ] && hash -d log="$LOG"
	[ -d "$OVERLAY" ] && hash -d overlay="$OVERLAY"
	[ -d "$PORTAGE" ] && hash -d portage="$PORTAGE"

	jump() {
		local DIR="${*%%/}"
		cd ~"$DIR" || return 1
	}
}
