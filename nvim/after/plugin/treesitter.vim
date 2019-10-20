if exists('g:loaded_treesitter') || !exists('g:loaded_nvim_treesitter') || &compatible
	finish
endif
let g:loaded_treesitter = 1

lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = "all",
	highlight = {
		enable = true
	},
}
EOF
