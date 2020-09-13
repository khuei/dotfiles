if exists('g:loaded_autocomplete') || &compatible
	finish
endif
let g:loaded_autocomplete = 1

let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

let g:UltiSnipsMappingsToIgnore = ['autocomplete']
let g:UltiSnipsSnippetDirectories = ['ultisnips']

inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

if exists(':UltiSnipsEdit')
	execute 'inoremap <silent> ' . g:UltiSnipsExpandTrigger .
				\ ' <C-R>=autocomplete#expand_or_jump("N")<CR>'
	execute 'snoremap <silent> ' . g:UltiSnipsExpandTrigger .
				\ ' <Esc>:call autocomplete#expand_or_jump("N")<CR>'
	execute 'inoremap <silent> ' . g:UltiSnipsJumpBackwardTrigger .
				\ ' <C-R>=autocomplete#expand_or_jump("P")<CR>'
	execute 'snoremap <silent> ' . g:UltiSnipsJumpBackwardTrigger .
				\ ' <Esc>:call autocomplete#expand_or_jump("P")<CR>'
endif

if has('autocmd')
	augroup autocomplete
		autocmd!
		autocmd! User UltiSnipsEnterFirstSnippet
		autocmd User UltiSnipsEnterFirstSnippet call autocomplete#setup_mappings()
		autocmd! User UltiSnipsExitLastSnippet
		autocmd User UltiSnipsExitLastSnippet call autocomplete#teardown_mappings()
	augroup END
	
	augroup idleboot
		autocmd!
		if has('vim_starting')
			autocmd CursorHold,CursorHoldI * call autocomplete#deoplete_init()
		endif
	augroup END
endif
