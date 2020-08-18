#!/usr/bin/env zsh

setup_hash() {
	if command -v hash > /dev/null; then
		local CODE=~/code
		local CONSOLEFONT=/usr/share/consolefonts
		local FONT=/usr/share/fonts
		local LINUX=/usr/src/linux
		local LOG=/var/log
		local OVERLAY=/var/db/repos
		local PORTAGE=/etc/portage

		test -d "$CODE" && hash -d code="$CODE"
		test -d "$CONSOLEFONT" && hash -d consolefont="$CONSOLEFONT"
		test -d "$FONT" && hash -d font="$FONT"
		test -d "$LINUX" && hash -d linux="$LINUX"
		test -d "$LOG" && hash -d log="$LOG"
		test -d "$OVERLAY" && hash -d overlay="$OVERLAY"
		test -d "$PORTAGE" && hash -d portage="$PORTAGE"

		jump() {
			local DIR="${*%%/}"
			cd ~"$DIR" || exit 1
		}
	fi
}

setup_hash
