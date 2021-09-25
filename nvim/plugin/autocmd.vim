if has('autocmd')
	augroup color
		autocmd!
		autocmd ColorScheme *
		\ lua require('plugin.colors').setup_highlight()
		autocmd VimEnter,FocusGained *
		\ lua require('plugin.colors').check_colorscheme()
	augroup END

	augroup settings
		autocmd!
		autocmd BufEnter * lua require('plugin.settings').buf_enter()
		autocmd FocusGained * lua require('plugin.settings').focus_gained()
		autocmd FocusLost * lua require('plugin.settings').focus_lost()
		autocmd InsertEnter * lua require('plugin.settings').insert_enter()
		autocmd InsertLeave * lua require('plugin.settings').insert_leave()
		autocmd VimEnter * lua require('plugin.settings').vim_enter()
		autocmd WinEnter * lua require('plugin.settings').win_enter()
		autocmd WinLeave * lua require('plugin.settings').win_leave()
		autocmd TextYankPost * lua vim.highlight.on_yank{timeout=200}
	augroup END
endif
