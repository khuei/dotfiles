fpath=(
	~/.zsh/completions
	~/.zsh/config
	$fpath
)

setopt AUTO_CD
setopt CORRECT_ALL
setopt EXTENDED_GLOB
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt LIST_PACKED
setopt MENU_COMPLETE
setopt SHARE_HISTORY

. ~/.zsh/config/bindings.zsh
. ~/.zsh/config/colors.zsh
. ~/.zsh/config/completion.zsh
. ~/.zsh/config/hash.zsh
. ~/.zsh/config/prompt.zsh
. ~/.zsh/config/wrappers.zsh
. ~/.zsh/config/aliases.zsh

. ~/.zsh/plugin/zsh-autosuggestions/zsh-autosuggestions.zsh
. ~/.zsh/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
