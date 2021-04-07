export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

unset PATH
[ -d ~/.cargo/bin ] && PATH=$PATH:~/.cargo/bin
[ -d ~/.local/bin ] && PATH=$PATH:~/.local/bin
[ -d ~/bin ] && PATH=$PATH:~/bin

PATH=$PATH:/bin
PATH=$PATH:/sbin

PATH=$PATH:/usr/bin
PATH=$PATH:/usr/sbin

PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
export PATH

export XDG_CONFIG_HOME=~

if [ "$(command -v nvim)" ]; then
	export EDITOR=nvim
elif [ "$(command -v vim)" ]; then
	export EDITOR=vim
fi

if [ "$(command -v less)" ]; then
	export MANPAGER=less
	export PAGER=less
elif [ "$(command -v more)" ]; then
	export MANPAGER=more
	export PAGER=more
fi

export DISABLE_UPDATE_PROMPT=true

export GPG_TTY=$(tty)

export HISTSIZE=1000000
export HISTFILE=~/.history
export SAVEHIST=$HISTSIZE

export KEYTIMEOUT=1

export LESS='-iFMRSX'

export LESSHISTFILE=/dev/null

export LESS_TERMCAP_mb=$(printf '\033[01;31m')
export LESS_TERMCAP_md=$(printf '\033[01;38;5;208m')
export LESS_TERMCAP_me=$(printf '\033[0m')
export LESS_TERMCAP_se=$(printf '\033[0m')
export LESS_TERMCAP_so=$(printf '\033[1;44;33m')
export LESS_TERMCAP_ue=$(printf '\033[0m')
export LESS_TERMCAP_us=$(printf '\033[04;38;5;111m')

{
	zcompare() {
		[ -s "$1" ] && [ ! -s "$1".zwc ] || \
		[ -n "$(find -L "$1" -prune -newer "$1".zwc 2>/dev/null)" ] && \
			zcompile -M "$1"
	}

	zcompare ~/.zcompdump
	zcompare ~/.zprofile
	zcompare ~/.zshrc

	for file in ~/.zsh/**/*.{sh,zsh}; do
		zcompare "$file" 2>/dev/null
	done

	unfunction zcompare
} >/dev/null &! exec zsh
