if vim.fn.executable('bash-language-server') == 1 then
	require('lspconfig').bashls.setup({})
end

if vim.fn.executable('clangd') == 1 then
	require('lspconfig').clangd.setup({})
end

if vim.fn.executable('gopls') == 1 then
	require('lspconfig').gopls.setup({})
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

if vim.fn.executable('lua-language-server') == 1 then
	require('lspconfig').sumneko_lua.setup({
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
					path = runtime_path,
				},
				diagnostics = {
					globals = {'vim'},
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})
end

if vim.fn.executable('pyright-langserver') then
	require('lspconfig').pyright.setup({})
elseif vim.fn.executable('pyls') == 1 then
	require('lspconfig').pyls.setup({})
end

if vim.fn.executable('rust-analyzer') == 1 then
	require('lspconfig').rust_analyzer.setup({})
elseif vim.fn.executable('rls') == 1 then
	require('lspconfig').rls.setup({})
end

vim.api.nvim_set_keymap('n', '<Leader>ds',
'<cmd>lua vim.diagnostic.open_float()<CR>',
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

vim.fn.sign_define('DiagnosticSignError', { text = 'x', texthl =
'DiagnosticSignError', numhl = 'DiagnosticSignError' })

vim.fn.sign_define('DiagnosticSignWarn', { text = 'w', texthl =
'DiagnosticSignWarn', numhl = 'DiagnosticSignWarn' })

vim.fn.sign_define('DiagnosticSignInfo', { texthl =
'DiagnosticSignInfo', text = 'i', numhl = 'DiagnosticSignInfo' })

vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', text
= 'h', numhl = 'DiagnosticSignHint' })
