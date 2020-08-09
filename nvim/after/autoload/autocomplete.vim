if exists('g:autoloaded_autocomplete') || &compatible
	finish
endif
let g:autoloaded_autocomplete = 1

let s:expansion_active = 0

function! autocomplete#setup_mappings() abort
	execute 'inoremap <buffer> <silent> ' . g:UltiSnipsJumpForwardTrigger .
				\ ' <C-R>=autocomplete#expand_or_jump("N")<CR>'
	execute 'snoremap <buffer> <silent> ' . g:UltiSnipsJumpForwardTrigger .
				\ ' <Esc>:call autocomplete#expand_or_jump("N")<CR>'
	execute 'inoremap <buffer> <silent> ' . g:UltiSnipsJumpBackwardTrigger .
				\ ' <C-R>=autocomplete#expand_or_jump("P")<CR>'
	execute 'snoremap <buffer> <silent> ' . g:UltiSnipsJumpBackwardTrigger .
				\ ' <Esc>:call autocomplete#expand_or_jump("P")<CR>'

	imap <expr> <buffer> <silent> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
	smap <expr> <buffer> <silent> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

	let s:expansion_active = 1
endfunction

function! autocomplete#teardown_mappings() abort
	silent! iunmap <expr> <buffer> <CR>
	silent! sunmap <expr> <buffer> <CR>

	let s:expansion_active = 0
endfunction

let g:ulti_jump_backwards_res = 0
let g:ulti_jump_forwards_res = 0
let g:ulti_expand_res = 0

function! autocomplete#expand_or_jump(direction) abort
	call UltiSnips#ExpandSnippet()
	if g:ulti_expand_res == 0
		if pumvisible()
			if a:direction ==# 'N'
				return "\<C-N>"
			else
				return "\<C-P>"
			endif
		else
			if s:expansion_active
				if a:direction ==# 'N'
					call UltiSnips#JumpForwards()
					if g:ulti_jump_forwards_res == 0
						return "\<Tab>"
					endif
				else
					call UltiSnips#JumpBackwards()
				endif
			else
				if a:direction ==# 'N'
					return "\<Tab>"
				endif
			endif
		endif
	endif

	return ''
endfunction

function! autocomplete#deoplete_init() abort
	if exists("g:deoplete_init_done") || !exists('g:loaded_deoplete')
		return
	endif
	let g:deoplete_init_done = 1

	call deoplete#enable()
	call deoplete#custom#source('file', 'rank', 2000)
	call deoplete#custom#source('ultisnips', 'rank', 1000)
	call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
endfunction
