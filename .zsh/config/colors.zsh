#!/usr/bin/env zsh

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

	color_setup() {
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
		0)
			BACKGROUND='dark' ;;
		1)
			BACKGROUND='light' ;;
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
		color_setup "$PREVIOUS_SCHEME"
		;;

	'')
		[ -s "$BASE16_CONFIG" ] || {
			color_setup 'default-dark'
			return 0
		}

		local SCHEME="$(head -1 "$BASE16_CONFIG")"
		color_setup "$SCHEME"
		;;

	*)
		color_setup "$SCHEME"
		;;
	esac

	unfunction luma
	unfunction color_setup
}

color "$@"
