local lspconfig = {}

if vim.fn.executable('clangd') == 1 then
	require('lspconfig').clangd.setup{}
end

if vim.fn.executable('rls') == 1 then
	require('lspconfig').rls.setup{}
end

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<Leader>ds',
'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

vim.api.nvim_set_keymap('n', '<Leader>dn',
'<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

vim.api.nvim_set_keymap('n', '<Leader>dN',
'<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)

vim.api.nvim_set_keymap('n', 'K',
'<cmd>lua vim.lsp.buf.hover()<CR>', opts)

vim.api.nvim_set_keymap('n', 'g0',
'<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

vim.api.nvim_set_keymap('n', 'gW',
'<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)

vim.api.nvim_set_keymap('n', 'gd',
'<cmd>lua vim.lsp.buf.declaration()<CR>', opts)

vim.api.nvim_set_keymap('n', 'gr',
'<cmd>lua vim.lsp.buf.references()<CR>', opts)

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
