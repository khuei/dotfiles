###########################################################
###################### Plugins ############################
###########################################################

. ~/.zsh/plugin/zsh-autosuggestions/zsh-autosuggestions.zsh
. ~/.zsh/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

###########################################################
##################### General #############################
###########################################################

fpath=(
	~/.zsh/completions
	~/.zsh/config
	$fpath
)

setopt AUTO_CD
setopt CD_SILENT
setopt PUSHD_SILENT
setopt SHARE_HISTORY

###########################################################
###################### Bindings ###########################
###########################################################

bindkey -v

[ "$(tput cbt)" ] && bindkey "$(tput cbt)" reverse-menu-complete

zle-keymap-select zle-line-init () {
	if [ "$TERM" = "linux" ]; then
		printf '\033[?16;0;224c'
	else
		case "$KEYMAP" in
		vicmd)
			printf '\033[2 q' ;;
		main|vinns)
			printf '\033[6 q' ;;
		*)
			printf '\033[2 q' ;;
		esac
	fi
}
zle -N zle-line-init
zle -N zle-keymap-select

fg-bg() {
	if [ "$#BUFFER" -eq 0 ]; then
		BUFFER="fg >/dev/null"
		zle accept-line -w
	else
		zle push-input -w
		zle clear-screen -w
	fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

###########################################################
#################### Completions ##########################
###########################################################

autoload -Uz compinit
[ -s ~/.zcompdump ] || {
	compinit -C
}
compinit -i -u

setopt MENU_COMPLETE
setopt LIST_PACKED

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list \
	'+m:{[:lower:]}={[:upper:]}' \
	'+m:{[:upper:]}={[:lower:]}' \
	'r:|?=** m:{a-z\-}={A-Z\_}'
zstyle ':completion:*' list-colors "$LS_COLORS"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B--- %d ---%b%f

###########################################################
#################### Colorscheme ##########################
###########################################################

color() {
	local SCHEME="$1"
	local BASE16_DIR=~/.zsh/colors
	local BASE16_CONFIG=~/.base16
	local BASE16_CONFIG_PREVIOUS="$BASE16_CONFIG.previous"

	luma() {
		local COLOR_HEX="$1"

		[ -n "$COLOR_HEX" ] || {
			echo "Missing argument hex color (RRGGBB)" 1>&2
			return 1
		}

		local COLOR_HEX_RED=$(echo "$COLOR_HEX" | cut -c 1-2)
		local COLOR_HEX_GREEN=$(echo "$COLOR_HEX" | cut -c 3-4)
		local COLOR_HEX_BLUE=$(echo "$COLOR_HEX" | cut -c 5-6)

		local COLOR_DEC_RED=$((16#$COLOR_HEX_RED))
		local COLOR_DEC_GREEN=$((16#$COLOR_HEX_GREEN))
		local COLOR_DEC_BLUE=$((16#$COLOR_HEX_BLUE))

		local COLOR_LUMA_RED=$((0.2126 * COLOR_DEC_RED))
		local COLOR_LUMA_GREEN=$((0.7152 * COLOR_DEC_GREEN))
		local COLOR_LUMA_BLUE=$((0.0722 * COLOR_DEC_BLUE))

		local COLOR_LUMA=$((COLOR_LUMA_RED + COLOR_LUMA_GREEN + COLOR_LUMA_BLUE))

		echo "$COLOR_LUMA"
	}

	setup() {
		local SCHEME="$1"
		local FILE="$BASE16_DIR/base16-$SCHEME.sh"

		[ -f "$FILE" ] || {
			echo "Colorscheme \"$SCHEME\" not found in $BASE16_DIR" 1>&2
			return 1
		}

		local BG=$(grep color_background= "$FILE" | cut -d \" -f2 | sed -e 's#/##g')
		local LUMA=$(luma "$BG")

		local LIGHT=$((LUMA > 127.5))
		local BACKGROUND

		case "$LIGHT" in
		0) BACKGROUND='dark' ;;
		1) BACKGROUND='light' ;;
		esac

		[ -f "$BASE16_CONFIG" ] && \
			cp "$BASE16_CONFIG" "$BASE16_CONFIG_PREVIOUS" >/dev/null

		echo "$SCHEME" > "$BASE16_CONFIG"
		echo "$BACKGROUND" >> "$BASE16_CONFIG"

		sh "$FILE"

		[ -n "$TMUX" ] || return 0

		CC=$(grep color18= "$FILE" | cut -d \" -f2 | sed -e 's#/##g')

		[ -n "$BG" ] && [ -n "$CC" ] || return 0

		command tmux set -a window-active-style "bg=#$BG"
		command tmux set -a window-style "bg=#$CC"
		command tmux set -g pane-active-border-style "bg=#$CC"
		command tmux set -g pane-border-style "bg=#$CC"
	}

	case "$SCHEME" in
	-)
		[ -s "$BASE16_CONFIG_PREVIOUS" ] || {
			echo "warning: no previous config found at $BASE16_CONFIG_PREVIOUS" 1>&2
			return 1
		}

		local PREVIOUS_SCHEME="$(head -1 "$BASE16_CONFIG_PREVIOUS")"
		setup "$PREVIOUS_SCHEME"
		;;
	'')
		[ -s "$BASE16_CONFIG" ] || {
			setup 'default-dark'
			return 0
		}

		local SCHEME="$(head -1 "$BASE16_CONFIG")"
		setup "$SCHEME"
		;;
	*)
		setup "$SCHEME"
		;;
	esac

	unfunction luma
	unfunction setup
}

color "$@"

###########################################################
####################### Prompt ############################
###########################################################

setopt PROMPT_SUBST
setopt EXTENDED_GLOB

autoload -Uz add-zsh-hook

local LVL
if [ -n "$TMUX" ]; then
	LVL=$((SHLVL-1))
else
	LVL=$SHLVL
fi

local SUFFIX
if [ "$(id -u)" -eq 0 ]; then
	SUFFIX="%F{yellow}%n%f$(printf '%%F{yellow}❯%.0s%%f' {1..$LVL})"
else
	SUFFIX=$(printf '%%F{red}❯%.0s%%f' {1..$LVL})
fi

export PS1="%F{blue}%B%1~%b%F{yellow}%B%(1j.*.)%(?..!)%b%f %B${SUFFIX}%b "

prompt_window_title_setup() {
	local CMD="${1:gs/$/\\$}"
	print -Pn "\033]0;$CMD:q\a"
}

prompt_preexec() {
	typeset -Fg SECONDS
	ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}

	HISTCMD_LOCAL=$((++HISTCMD_LOCAL))

	case $TTY in
		/dev/ttyS[0-9]*) return ;;
	esac

	if [ -n "$TMUX" ]; then
		prompt_window_title_setup "$2"
	else
		prompt_window_title_setup "$(basename "$PWD") > $2"
	fi
}
add-zsh-hook preexec prompt_preexec

prompt_precmd() {
	if [ "$ZSH_START_TIME" ]; then
		local DELTA=$((SECONDS - ZSH_START_TIME))
		local DAYS=$((~~(DELTA / 86400)))
		local HOURS=$((~~((DELTA - DAYS * 86400) / 3600)))
		local MINUTES=$((~~((DELTA - DAYS * 86400 - HOURS * 3600) / 60)))
		local SECS=$((DELTA - DAYS * 86400 - HOURS * 3600 - MINUTES * 60))
		local ELAPSED

		[ "$DAYS" -ne 0 ] && ELAPSED="${DAYS}d"
		[ "$HOURS" -ne 0 ] && ELAPSED="${ELAPSED}${HOURS}h"
		[ "$MINUTES" -ne 0 ] && ELAPSED="${ELAPSED}${MINUTES}m"

		if [ -z "$ELAPSED" ]; then
			SECS="$(print -f "%.2f" $SECS)s"
		elif [ "$DAYS" -ne 0 ]; then
			SECS=""
		else
			SECS="$((~~SECS))s"
		fi

		ELAPSED="${ELAPSED}${SECS}"

		export RPS1="%F{cyan}%{$(printf '\033[3m')%}${ELAPSED}%f%{$(printf '\033[0m')%} "
		export RPS3="%F{blue}%~%f"

		unset ZSH_START_TIME
	else
		export RPS3="%F{blue}%~%f"
	fi

	if [ "$HISTCMD_LOCAL" -eq 0 ]; then
		prompt_window_title_setup "$(basename "$PWD")"
	else
		local LAST="$(history | tail -1 | awk '{print $2}')"
		if [ -n "$TMUX" ]; then
			prompt_window_title_setup "$LAST"
		else
			prompt_window_title_setup "$(basename "$PWD") > $LAST"
		fi
	fi

}
add-zsh-hook precmd prompt_precmd

prompt_chpwd() {
	zle && zle -I
	export RPROMPT=
	zle && [[ $CONTEXT == start ]] && prompt_async
	true
}
add-zsh-hook chpwd prompt_chpwd

prompt_async_precmd() {
	local fd=
	exec {fd}< <( prompt_git_info )
	zle -Fw "$fd" prompt_async_callback
	true
}
add-zsh-hook precmd prompt_async_precmd

prompt_git_info() {
	local REPLY=
	{
		local is_modified=false has_unstaged=false has_untracked=false

		if [ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
			[ -n "$(git diff 2>/dev/null)" ] && is_modified=true
			[ -n "$(git diff --cached 2>/dev/null)" ] && has_staged=true
			[ -n "$(git ls-files --exclude-standard --others 2>/dev/null)" ] && 
				has_untracked=true

			REPLY="[$(git branch | sed -n '/\* /s///p' 2>/dev/null)"

			[ "$has_staged" = true ] && REPLY="$REPLY%F{green}●%f"
			[ "$is_modified" = true ] && REPLY="$REPLY%F{red}●%f"
			[ "$has_untracked" = true ] && REPLY="$REPLY%F{blue}●%f"

			REPLY="$REPLY] "
		fi
	} always {
		print -r -- "$RPS1$REPLY$RPS3"
	}
}

prompt_async_callback() {
	local fd=$1 REPLY
	{
		zle -F "$fd"
		read -ru $fd
		[[ $RPROMPT == $REPLY ]] && return
		export RPROMPT=$REPLY
		zle && [[ $CONTEXT == start ]] && zle reset-prompt
	} always {
		export RPROMPT=
		exec {fd}<&-
	}
}
zle -N prompt_async_callback

###########################################################
####################### Aliases ###########################
###########################################################

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

###########################################################
##################### Wrappers ############################
###########################################################

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
		tail -f "$UEBERZUG_FIFO" | ueberzug layer --silent --parser simple --loader thread &! \
		command vifm "$@"
	}
}

[ "$(command -v xinit)" ] && [ "$TERM" = "linux" ] && {
	xinit() {
		vt=$(tty | sed "s/\/dev\/tty/vt/")
		command xinit "$1" -- "$vt"
	}
}

true
