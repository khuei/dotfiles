if executable('python3')
	let g:python3_host_prog='python3'
endif

if &loadplugins
	if has('packages')
		packadd! deoplete
		packadd! deoplete-lsp
		packadd! lspconfig
		packadd! treesitter
		packadd! ultisnips
	endif
endif
