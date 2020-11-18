if exists('g:loaded_lsp') || !exists('g:lspconfig') || &compatible
	finish
endif
let g:loaded_lsp = 1

if executable('clangd')
	lua require'lspconfig'.clangd.setup{}
endif

if executable('rls')
	lua require'lspconfig'.rls.setup{}
endif

nnoremap <silent> <leader>ds <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>dN <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> g0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

if $TERM !~# '^linux'
	sign define LspDiagnosticsSignError text=✖
	sign define LspDiagnosticsSignWarning text=
	sign define LspDiagnosticsSignInformation text=
	sign define LspDiagnosticsSignHint text=➤
endif

function! s:SetupLspHighlights() abort
	exec 'highlight LspDiagnosticsDefaultError cterm=italic gui=italic ' .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('WarningMsg')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsDefaultHint cterm=italic gui=italic ' .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('ModeMsg')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsDefaultInformation cterm=italic gui=italic ' .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('Conditional')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsDefaultWarning cterm=italic gui=italic' .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')

	exec 'highlight LspDiagnosticsSignError' .
				\ ' guibg=' . synIDattr(synIDtrans(hlID('ColorColumn')), 'bg', 'gui') .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('WarningMsg')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsSignHint' .
				\ ' guibg=' . synIDattr(synIDtrans(hlID('ColorColumn')), 'bg', 'gui') .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('ModeMsg')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsSignInformation' .
				\ ' guibg=' . synIDattr(synIDtrans(hlID('ColorColumn')), 'bg', 'gui') .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('Conditional')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsSignWarning' .
				\ ' guibg=' . synIDattr(synIDtrans(hlID('ColorColumn')), 'bg', 'gui') .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')
endfunction

if has('autocmd')
	augroup highlight
		autocmd!
		autocmd ColorScheme * call s:SetupLspHighlights()
	augroup END
endif
