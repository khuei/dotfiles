if exists('g:loaded_colors') || &compatible
	finish
endif
let g:loaded_colors = 1

if has('autocmd')
	augroup color
		autocmd!
		autocmd ColorScheme *
		\ lua require('plugin.colors').setup_highlight()
		autocmd VimEnter,FocusGained *
		\ lua require('plugin.colors').check_colorscheme()
	augroup END
endif
