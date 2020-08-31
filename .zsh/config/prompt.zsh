#!/usr/bin/env zsh

prompt_window_title_setup() {
	CMD="${1:gs/$/\\$}"
	print -Pn "\033]0;$CMD:q\a"
}

prompt_preexec() {
	setopt EXTENDED_GLOB

	typeset -Fg SECONDS
	ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}

	HISTCMD_LOCAL=$((++HISTCMD_LOCAL))

	TRIMMED="${2[(wr)^(*=*|ssh|sudo|-*)]}"
	if [ -n "$TMUX" ]; then
		prompt_window_title_setup "$TRIMMED"
	else
		prompt_window_title_setup "$(basename "$PWD") > $TRIMMED"
	fi
}

prompt_precmd() {
	local RPROMPT_BASE="\${vcs_info_msg_0_}%F{blue}%~%f"

	if [ "$ZSH_START_TIME" ]; then
		DELTA=$((SECONDS - ZSH_START_TIME))
		DAYS=$((~~(DELTA / 86400)))
		HOURS=$((~~((DELTA - DAYS * 86400) / 3600)))
		MINUTES=$((~~((DELTA - DAYS * 86400 - HOURS * 3600) / 60)))
		SECS=$((DELTA - DAYS * 86400 - HOURS * 3600 - MINUTES * 60))
		ELAPSED=""

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

		RPROMPT="%F{cyan}%{$(printf '\033[3m')%}${ELAPSED}%f%{$(printf '\033[0m')%} $RPROMPT_BASE"
		export RPROMPT

		unset ZSH_START_TIME
	else
		export RPROMPT="$RPROMPT_BASE"
	fi

	if [ "$HISTCMD_LOCAL" -eq 0 ]; then
		prompt_window_title_setup "$(basename "$PWD")"
	else
		LAST="$(history | tail -1 | awk '{print $2}')"
		if [ -n "$TMUX" ]; then
			prompt_window_title_setup "$LAST"
		else
			prompt_window_title_setup "$(basename "$PWD") > $LAST"
		fi
	fi
}

prompt_vcs_info() {
	zstyle ":vcs_info:*" enable git
	zstyle ":vcs_info:*" check-for-changes true
	zstyle ":vcs_info:*" stagedstr "%F{green}●%f"
	zstyle ":vcs_info:*" unstagedstr "%F{red}●%f"
	zstyle ":vcs_info:*" use-simple true
	zstyle ":vcs_info:git+set-message:*" hooks git-untracked
	zstyle ":vcs_info:git*:*" formats "[%b%m%c%u] "
	zstyle ":vcs_info:git*:*" actionformats "[%b|%a%m%c%u] "

	+vi-git-untracked() {
		[ -n "$(git ls-files --exclude-standard --others 2> /dev/null)" ] && \
			hook_com[unstaged]+="%F{blue}●%f"
	}

	vcs_info
}

prompt_async_renice() {
	[ "$(command -v renice)" ] && renice +15 -p $$

	[ "$(command -v ionice)" ] && ionice -c 3 -p $$
}

prompt_async_init() {
	typeset -g prompt_async_init
	(( ${prompt_async_init:-0} )) && return 0
	prompt_async_init=1

	async_start_worker prompt_async -u -n
	async_register_callback prompt_async prompt_async_callback
	async_worker_eval prompt_async prompt_async_renice
}

prompt_async_tasks() {
	prompt_async_init
	async_worker_eval prompt_async builtin cd -- "$PWD"
	async_job prompt_async prompt_vcs_info
}

prompt_async_callback() {
	job="$1" error="$2"

	case "$job" in
	\[async])
		(( error == 2 )) || (( error == 3 )) || (( error == 130 )) && {
			typeset -g prompt_async_init=0
			async_stop_worker prompt_async
			prompt_async_init
			prompt_async_tasks
		}
		;;
	\[async/eval])
		(( error )) && prompt_async_tasks
		;;
	prompt_vcs_info)
		prompt_vcs_info
		zle .reset-prompt
		;;
	esac
}

prompt_init() {
	setopt PROMPT_SUBST

	autoload -Uz async.zsh && async.zsh
	autoload -Uz add-zsh-hook
	autoload -Uz vcs_info

	if [ -n "$TMUX" ]; then
		LVL=$((SHLVL-1))
	else
		LVL=$SHLVL
	fi

	if [ "$(id -u)" -eq 0 ]; then
		SUFFIX="%F{yellow}%n%f$(printf '%%F{yellow}❯%.0s%%f' {1..$LVL})"
	else
		SUFFIX=$(printf '%%F{red}❯%.0s%%f' {1..$LVL})
	fi

	export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%B%1~%b%F{yellow}%B%(1j.*.)%(?..!)%b%f %B${SUFFIX}%b "

	add-zsh-hook precmd prompt_async_tasks
	add-zsh-hook precmd prompt_precmd
	add-zsh-hook preexec prompt_preexec
}

prompt_init
