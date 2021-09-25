require('plugin.mappings')
require('plugin.settings')

vim.g.coq_settings = {
	auto_start = 'shut-up',
}

if vim.api.nvim_get_option('loadplugins') then
	if vim.fn.has('packages') == 1 then
		vim.cmd([[packad coq]])
		vim.cmd([[packadd lspconfig]])
		vim.cmd([[packadd treesitter]])
	end
end
