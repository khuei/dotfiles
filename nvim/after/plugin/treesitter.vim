if !exists('g:loaded_nvim_treesitter') || &compatible
	finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = "all",
	highlight = {
		enable = true
	},
}
EOF
