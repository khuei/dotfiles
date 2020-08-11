export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

unset PATH

if [ -d ~/.cargo/bin ]; then
	PATH=$PATH:~/.cargo/bin
fi

if [ -d ~/.local/bin ]; then
	PATH=$PATH:~/.local/bin
fi

if [ -d ~/bin ]; then
	PATH=$PATH:~/bin
fi

if [ -d /usr/lib/llvm/10/bin ]; then
	PATH=$PATH:/usr/lib/llvm/10/bin
fi

PATH=$PATH:/bin
PATH=$PATH:/sbin

PATH=$PATH:/usr/bin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/sbin
export PATH

export XDG_CACHE_HOME=~
export XDG_CONFIG_HOME=~
export XDG_DATA_HOME=~
export XDG_RUNTIME_DIR=~
export XDG_DATA_DIRS=~
export XDG_CONFIG_DIRS=~

if command -v nvim > /dev/null; then
	export EDITOR=nvim
elif command -v vim > /dev/null; then
	export EDITOR=vim
else
	export EDITOR=vi
fi

if command -v less > /dev/null; then
	export MANPAGER=less
	export PAGER=less
elif command -v more > /dev/null; then
	export MANPAGER=more
	export PAGER=more
fi

(
	zcompare() {
		if [ -s "$1" ] && [ ! -s "$1".zwc ] || \
		   [ -n "$(find -L "$1" -prune -newer "$1".zwc)" ]; then
			zcompile -M "$1"
		fi
	}

	zcompare ~/.zcompdump
	zcompare ~/.zprofile
	zcompare ~/.zshenv
	zcompare ~/.zshrc

	for file in ~/.zsh/**/*.{sh,zsh}; do
		zcompare "$file" 2> /dev/null
	done

	unfunction zcompare
) > /dev/null &!
