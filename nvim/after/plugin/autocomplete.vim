if exists('g:loaded_autocomplete') || &compatible
	finish
endif
let g:loaded_autocomplete = 1

lua require('config.autocomplete')

if has('autocmd')
	augroup autocomplete
		autocmd!
		autocmd! User UltiSnipsEnterFirstSnippet
		autocmd User UltiSnipsEnterFirstSnippet lua require'config.autocomplete'.setup_mappings()
		autocmd! User UltiSnipsExitLastSnippet
		autocmd User UltiSnipsExitLastSnippet lua require'config.autocomplete'.teardown_mappings()
	augroup END
	
	augroup idleboot
		autocmd!
		if has('vim_starting')
			autocmd CursorHold,CursorHoldI * lua require'config.autocomplete'.deoplete_init()
		endif
	augroup END
endif
