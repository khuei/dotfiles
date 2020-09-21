if exists('g:loaded_lsp') || !exists('g:nvim_lsp') || &compatible
	finish
endif
let g:loaded_lsp = 1

if executable('clangd')
	lua require'nvim_lsp'.clangd.setup{}
endif

if executable('rls')
	lua require'nvim_lsp'.rls.setup{}
endif

nnoremap <silent> <Leader>ld <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> g0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

if $TERM !~# '^linux'
	sign define LspDiagnosticsErrorSign text=✖
	sign define LspDiagnosticsWarningSign text=
	sign define LspDiagnosticsInformationSign text=
	sign define LspDiagnosticsHintSign text=➤
endif

function! s:SetupLspHighlights() abort
	exec 'highlight LspDiagnosticsError cterm=italic gui=italic ' .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('WarningMsg')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsHint cterm=italic gui=italic ' .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('ModeMsg')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsInformation cterm=italic gui=italic ' .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('Conditional')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsWarning cterm=italic gui=italic' .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')

	exec 'highlight LspDiagnosticsErrorSign' .
				\ ' guibg=' . synIDattr(synIDtrans(hlID('ColorColumn')), 'bg', 'gui') .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('WarningMsg')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsHintSign' .
				\ ' guibg=' . synIDattr(synIDtrans(hlID('ColorColumn')), 'bg', 'gui') .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('ModeMsg')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsInformationSign' .
				\ ' guibg=' . synIDattr(synIDtrans(hlID('ColorColumn')), 'bg', 'gui') .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('Conditional')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsWarningSign' .
				\ ' guibg=' . synIDattr(synIDtrans(hlID('ColorColumn')), 'bg', 'gui') .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')
endfunction

if has('autocmd')
	augroup highlight
		autocmd!
		autocmd ColorScheme * call s:SetupLspHighlights()
	augroup END
endif
