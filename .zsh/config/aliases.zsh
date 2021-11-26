#!/usr/bin/env zsh

[ "$(command -v brightnessctl)" ] && alias bl=brightnessctl

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

[ "$(command -v systemctl)" ] && {
	alias sc='systemctl'
	alias scu='systemctl --user'
	alias scdr='systemctl daemon-reload'
	alias scdru='systemctl --user daemon-reload'
	alias scr='systemctl restart'
	alias scru='systemctl --user restart'
	alias sce='systemctl stop'
	alias sceu='systemctl --user stop'
	alias scs='systemctl start'
	alias scsu='systemctl --user start'
}

[ "$(command -v tmux)" ] && alias t=tmux

[ "$(command -v vifm)" ] && alias f=vifm

[ -n "$EDITOR" ] && alias v="${EDITOR:=vi}"

[ -n "$PAGER" ] && alias p="$PAGER"
