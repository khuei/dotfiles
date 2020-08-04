#!/usr/bin/env zsh

if command -v cc > /dev/null && \
   command -v c++ > /dev/null; then
	cc() {
		local filetype=$(echo "$1" | \grep -o "[^.]*$")
		if [ "$filetype" = "c" ]; then
			command cc $1
		elif [ "$filetype" = "cpp" ]; then
			command c++ $1
		fi
	}
fi

if command -v tmux > /dev/null; then
	tmux() {
		SOCK_SYMLINK=~/.ssh/ssh_auth_sock
		if [ -r "$SSH_AUTH_SOCK" ] && [ ! -L "$SSH_AUTH_SOCK" ]; then
			ln -sf "$SSH_AUTH_SOCK" "$SOCK_SYMLINK"
		fi

		if [ -n "$*" ]; then
			env SSH_AUTH_SOCK="$SOCK_SYMLINK" tmux "$@"
			return
		fi

		SESSION_NAME=$(basename "${$(pwd)//[.:]/_}")
		env SSH_AUTH_SOCK="$SOCK_SYMLINK" tmux new -A -s "$SESSION_NAME"
	}
fi

if command -v vifm > /dev/null; then
	vifm() {
		if command -v ueberzug > /dev/null; then
			export FIFO_UEBERZUG="/tmp/vifm-ueberzug-${PPID}"
			rm "$FIFO_UEBERZUG" 2> /dev/null
			mkfifo "$FIFO_UEBERZUG"
			trap 'rm \$FIFO_UEBERZUG 2> /dev/null && pkill -P $$ 2> /dev/null' EXIT
			tail -f "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash --loader thread &!

			command vifm "$@"

			rm "$FIFO_UEBERZUG" 2> /dev/null
			pkill -P $$ 2> /dev/null
			unset FIFO_UEBERZUG
		else
			command vifm "$@"
		fi
	}
fi

if command -v xinit > /dev/null; then
	xinit() {
		if [ "$TERM" = "linux" ]; then
			vt=$(tty | sed "s/\/dev\/tty/vt/")
			command xinit "$1" -- "$vt"
		fi
	}
fi
