require('plugin.mappings')

if vim.fn.executable('python3') == 1 then
	vim.api.nvim_set_var('python3_host_prog', 'python3')
end

if vim.api.nvim_get_option('loadplugins') then
	if vim.fn.has('packages') == 1 then
		vim.cmd([[packadd! deoplete]])
		vim.cmd([[packadd! deoplete-lsp]])
		vim.cmd([[packadd! fzy-native]])
		vim.cmd([[packadd! lspconfig]])
		vim.cmd([[packadd! plenary]])
		vim.cmd([[packadd! popup]])
		vim.cmd([[packadd! telescope]])
		vim.cmd([[packadd! treesitter]])
		vim.cmd([[packadd! ultisnips]])
	end
end
