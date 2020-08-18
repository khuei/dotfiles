#!/usr/bin/env zsh

[ "$(command -v cc)" ] && [ "$(command -v c++)" ] && {
	cc() {
		filetype=$(echo "$1" | grep -o '[^.]*$')
		case $filetype in
		'c')
			command cc "$1"
			;;
		'cpp')
			command c++ "$1"
			;;
		esac
	}
}

[ "$(command -v tmux)" ] && {
	tmux() {
		SOCK_SYMLINK=~/.ssh/ssh_auth_sock
		[ -r "$SSH_AUTH_SOCK" ] && [ ! -L "$SSH_AUTH_SOCK" ] && \
			ln -sf "$SSH_AUTH_SOCK" "$SOCK_SYMLINK"

		[ -n "$*" ] && {
			env SSH_AUTH_SOCK="$SOCK_SYMLINK" tmux "$@"
			return
		}

		SESSION_NAME=$(basename "${$(pwd)//[.:]/_}")
		env SSH_AUTH_SOCK="$SOCK_SYMLINK" tmux new -A -s "$SESSION_NAME"
	}
}

[ "$(command -v vifm)" ] && [ "$(command -v ueberzug)" ] && {
	vifm() {
		export FIFO_UEBERZUG="/tmp/vifm-ueberzug-$$"
		rm "$FIFO_UEBERZUG" 2> /dev/null
		mkfifo "$FIFO_UEBERZUG"
		trap 'rm $FIFO_UEBERZUG 2> /dev/null && pkill -P $$ 2> /dev/null' EXIT
		tail -f "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash --loader thread &!

		command vifm "$@"

		rm "$FIFO_UEBERZUG" 2> /dev/null
		pkill -P $$ 2> /dev/null
		unset FIFO_UEBERZUG
	}
}

[ "$(command -v xinit)" ] && [ "$TERM" = "linux" ] && {
	xinit() {
		vt=$(tty | sed "s/\/dev\/tty/vt/")
		command xinit "$1" -- "$vt"
	}
}
