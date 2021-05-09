#!/usr/bin/env zsh

[ "$(command -v color)" ] && alias c=color

[ "$(command -v git)" ] && {
	alias g=git
	alias groot="cd -- \$(git rev-parse --show-toplevel 2>/dev/null)"
}

[ "$(command -v ls)" ] && {
	alias ls='ls --color'
	alias l='ls -AFh'
	alias ll='ls -AlFh'
}

[ "$(command -v ncmpcpp)" ] && [ "$(command -v mpd)" ] && \
	alias n="[ -z \"\$(ps -opid= -C mpd)\" ] && mpd &! ncmpcpp 2>/dev/null"

[ "$(command -v ssh)" ] && alias s=ssh

[ "$(command -v tmux)" ] && alias t=tmux

[ "$(command -v vifm)" ] && alias f=vifm

[ -n "$EDITOR" ] && alias v="${EDITOR:=vi}"

[ -n "$PAGER" ] && alias p="$PAGER"
