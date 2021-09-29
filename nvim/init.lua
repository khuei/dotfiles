require('plugin.mappings')
require('plugin.settings')

vim.g.coq_settings = {
	xdg = false,
	auto_start = 'shut-up',
	display = {
		pum = {
			fast_close = false,
			source_context = {"[", "]"},
		},
		preview = {
			border = "single",
			positions = {
				east = 1,
				south = 2,
				north = 3,
				west = 4,
			},
		},
		ghost_text = {
			enabled = true,
			context = {"", ""},
		},
		icons = {
			mode = "none",
		}
	},
	keymap = {
		jump_to_mark = "<C-p>",
	}
}

if vim.api.nvim_get_option('loadplugins') then
	if vim.fn.has('packages') == 1 then
		vim.cmd([[packad coq]])
		vim.cmd([[packadd lspconfig]])
		vim.cmd([[packadd treesitter]])
	end
end
