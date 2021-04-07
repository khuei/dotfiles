local telescope = {}

require('telescope').setup {
	defaults = {
		file_sorter = require('telescope.sorters').get_fzy_sorter,
		file_previewer = require('telescope.previewers').vim_buffer_cat.new,
		grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
		qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		}
	}
}
require('telescope').load_extension('fzy_native')

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<Leader>f',
[[<cmd>lua require('telescope.builtin').find_files({ hidden = true })<CR>]],
opts)

vim.api.nvim_set_keymap('n', '<Leader>g',
[[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)

vim.api.nvim_set_keymap('n', '<Leader>b',
[[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)

return telescope
