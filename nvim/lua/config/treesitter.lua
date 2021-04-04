local treesitter = {}

require('nvim-treesitter.configs').setup {
	highlight = {
		enable = true
	},
}

return treesitter
