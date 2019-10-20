#!/usr/bin/env zsh

autoload -Uz compinit
if [ ! -s ~/.zcompdump ]; then
	compinit -C
	if [ ! -s ~/.zcomdump.zwc ]; then
		zcompile -M ~/.zcompdump
	fi
else
	compinit -i -u
fi

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B--- %d ---%b%f
