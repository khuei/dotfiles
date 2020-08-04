#!/usr/bin/env zsh

alias ......="cd ../../.."
alias ....="cd ../.."
alias ..="cd .."

alias dud="du -d 1 -h"
alias duf="du -sh *"

alias e="exit"

alias fd="find . -type d -name"
alias ff="find . -type f -name"

alias grep="grep -HRn --color"

alias h="history"

alias l="ls -lFh"
alias ll="ls -lAFh"
alias ls="ls --color"

if command -v alsamixer > /dev/null; then
	alias a=alsamixer
fi

if command -v cargo > /dev/null; then
	alias cbench='cargo bench'
	alias cbuild='cargo build'
	alias ccheck='cargo check'
	alias cclean='cargo clean'
	alias crun='cargo run'
	alias ctest='cargo test'
fi

if command -v clang-format > /dev/null; then
	alias cformat="clang-format"
fi

if command -v clang-tidy > /dev/null; then
	alias ctidy="clang-tidy"
fi

if command -v color > /dev/null; then
	alias c="color"
fi

if command -v clang-tidy > /dev/null; then
	alias ctidy="clang-tidy"
fi

if command -v git > /dev/null; then
	alias g=git
	alias groot="cd \$(git rev-parse --show-toplevel 2> /dev/null)"
fi

if command -v htop > /dev/null; then
	alias t=htop
elif command -v top > /dev/null; then
	alias t=top
fi

if command -v jump > /dev/null; then
	alias j=jump
fi

if command -v less > /dev/null; then
	alias r=less
elif command -v more > /dev/null; then
	alias r=more
fi

if command -v mpd > /dev/null && \
   command -v ncmpcpp > /dev/null; then
	alias n="[ -z \$(ps -opid= -C mpd) ] && mpd; ncmpcpp"
fi

if command -v nvim > /dev/null; then
	alias v=nvim
elif command -v vim > /dev/null; then
	alias v=vim
elif command -v vi > /dev/null; then
	alias v=vi
fi

if command -v ssh > /dev/null; then
	alias s=ssh
fi

if command -v tmux > /dev/null; then
	alias m=tmux
elif command -v screen > /dev/null; then
	alias m=screen
fi

if command -v vifm > /dev/null; then
	alias f=vifm
fi
