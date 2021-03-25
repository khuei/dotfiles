if !exists('g:loaded_nvim_treesitter') || &compatible
	finish
endif

lua require('config.treesitter')
