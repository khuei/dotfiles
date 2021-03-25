if !exists('g:lspconfig') || &compatible
	finish
endif

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
