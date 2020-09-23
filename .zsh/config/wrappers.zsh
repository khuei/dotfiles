#!/usr/bin/env zsh

[ "$(command -v cc)" ] && [ "$(command -v c++)" ] && {
	cc() {
		case "${1##*.}" in
		c)
			command cc "$1"
			;;

		cpp)
			command c++ "$1"
			;;

		*)
			echo 'error: no input files' 1>&2
			return 1
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
			return 0
		}

		env SSH_AUTH_SOCK="$SOCK_SYMLINK" tmux new -A -s "$(basename "${PWD//[\.]/_}")"
	}
}

[ "$(command -v vifm)" ] && [ "$(command -v ueberzug)" ] && {
	vifm() {
		export UEBERZUG_FIFO="/tmp/vifm-ueberzug-$$" || return 1
		mkfifo "$UEBERZUG_FIFO"
		trap 'rm $UEBERZUG_FIFO 2>/dev/null && unset UEBERZUG_FIFO;
		      pkill -P $$ 2>/dev/null' EXIT
		tail -f "$UEBERZUG_FIFO" | ueberzug layer --silent --parser bash --loader thread &! \
		command vifm "$@"
	}
}

[ "$(command -v xinit)" ] && [ "$TERM" = "linux" ] && {
	xinit() {
		vt=$(tty | sed "s/\/dev\/tty/vt/")
		command xinit "$1" -- "$vt"
	}
}
