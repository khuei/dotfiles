require('plugin.mappings')
require('plugin.settings')

if vim.fn.executable('python3') == 1 then
	vim.api.nvim_set_var('python3_host_prog', 'python3')
end

if vim.api.nvim_get_option('loadplugins') then
	if vim.fn.has('packages') == 1 then
		vim.cmd([[packadd compe]])
		vim.cmd([[packadd lspconfig]])
		vim.cmd([[packadd treesitter]])
	end
end

require('config.lsp')
require('config.treesitter')
