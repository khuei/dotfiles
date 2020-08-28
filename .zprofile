export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

unset PATH
[ -d /usr/lib/llvm/10/bin ] && PATH=$PATH:/usr/lib/llvm/10/bin
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

export XDG_CACHE_HOME=~
export XDG_CONFIG_DIRS=~
export XDG_CONFIG_HOME=~
export XDG_DATA_DIRS=~
export XDG_DATA_HOME=~
export XDG_RUNTIME_DIR=~

if command -v nvim > /dev/null; then
	export EDITOR=nvim
elif command -v vim > /dev/null; then
	export EDITOR=vim
fi

if command -v less > /dev/null; then
	export MANPAGER=less
	export PAGER=less
elif command -v more > /dev/null; then
	export MANPAGER=more
	export PAGER=more
fi

export DISABLE_UPDATE_PROMPT=true

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

export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.cfg=00;32:*.conf=00;32:*.diff=00;32:*.doc=00;32:*.ini=00;32:*.log=00;32:*.patch=00;32:*.pdf=00;32:*.ps=00;32:*.tex=00;32:*.txt=00;32:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

{
	zcompare() {
		[ -s "$1" ] && [ ! -s "$1".zwc ] || \
		[ -n "$(find -L "$1" -prune -newer "$1".zwc)" ] && \
			zcompile -M "$1"
	}

	zcompare ~/.zcompdump
	zcompare ~/.zprofile
	zcompare ~/.zshrc

	for file in ~/.zsh/**/*.{sh,zsh}; do
		zcompare "$file" 2> /dev/null
	done

	unfunction zcompare
} > /dev/null &!
