local lspconfig = {}

if vim.fn.executable('clangd') == 1 then
	require('lspconfig').clangd.setup({})
end

if vim.fn.executable('rust-analyzer') == 1 then
	require('lspconfig').rust_analyzer.setup({})
elseif vim.fn.executable('rls') == 1 then
	require('lspconfig').rls.setup({})
end

if vim.fn.executable('lua-language-server') == 1 then
	require('lspconfig').sumneko_lua.setup({
		cmd = { io.popen('which lua-language-server'):read(), '-E', os.getenv('HOME')
		.. '/.local/share/lua-language-server/main.lua' },
		settings = {
			Lua = {
				runtime = {
					path = vim.split(package.path, ';'),
				},
				diagnostics = {
					globals = { 'vim' },
					disable = { 'undefined-global' },
				},
				workspace = {
					library = {
						[vim.fn.expand('$VIMRUNTIME/lua')] = true,
						[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
					},
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})
end

vim.api.nvim_set_keymap('n', '<Leader>ds',
'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>dn',
'<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>dN',
'<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'K',
'<cmd>lua vim.lsp.buf.hover()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'g0',
'<cmd>lua vim.lsp.buf.document_symbol()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'gW',
'<cmd>lua vim.lsp.buf.workspace_symbol()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'gd',
'<cmd>lua vim.lsp.buf.declaration()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'gr',
'<cmd>lua vim.lsp.buf.references()<CR>',
{ noremap = true, silent = true })

if os.getenv('TERM') ~= 'linux' then
	vim.fn.sign_define('LspDiagnosticsSignError',
	{ texthl = 'LspDiagnosticsSignError', text = '✖',
	numhl = 'LspDiagnosticsSignError' })

	vim.fn.sign_define('LspDiagnosticsSignWarning',
	{ texthl = 'LspDiagnosticsSignWarning', text = '',
	numhl = 'LspDiagnosticsSignWarning' })

	vim.fn.sign_define('LspDiagnosticsSignInformation',
	{ texthl = 'LspDiagnosticsSignInformation', text = '',
	numhl = 'LspDiagnosticsSignInformation' })

	vim.fn.sign_define('LspDiagnosticsSignHint',
	{ texthl = 'LspDiagnosticsSignHint', text = '➤',
	numhl = 'LspDiagnosticsSignHint' })
end

return lspconfig
