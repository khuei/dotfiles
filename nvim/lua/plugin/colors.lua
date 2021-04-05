local colors = {}

colors.check_colorscheme = function()
	local config_file = io.open(os.getenv('HOME') .. '/.base16', 'r')

	if config_file then
		local index = 0
		local config = {}

		for line in config_file:lines() do
			config[index] = line
			index = index + 1
		end

		if config then
			vim.o.background = config[1]
		else
			error('Bad background: ' .. config[1])
		end

		local color = io.open(os.getenv('HOME') ..
		'/nvim/colors/base16-' .. config[0] .. '.vim')
		if color then
			vim.cmd('colorscheme base16-' .. config[0])
			color:close()
		else
			error('Bad scheme: ' .. config[0])
		end

		config_file:close()
	else
		vim.o.background = 'dark'
		vim.cmd('colorscheme base16-default-dark')
	end

	vim.cmd('doautocmd ColorScheme')
end

colors.setup_highlight = function()
	vim.cmd('highlight Comment cterm=italic gui=italic')

	local conceal_term_fg
	local conceal_gui_fg

	if vim.api.nvim_get_option('background') == 'dark' then
		conceal_term_fg = 239
		conceal_gui_fg = 'Grey30'
	else
		conceal_term_fg = 249
		conceal_gui_fg = 'Grey70'
	end

	vim.cmd('highlight clear Conceal')
	vim.cmd('highlight Conceal'
		.. ' ctermfg=' .. conceal_term_fg
		.. ' guifg=' .. conceal_gui_fg
	)

	vim.cmd('highlight clear CursorLineNr')
	vim.cmd('highlight link CursorLineNr DiffText')

	vim.cmd('highlight EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg')

	vim.cmd('highlight clear NonText')
	vim.cmd('highlight link NonText Conceal')

	vim.cmd('highlight clear Pmenu')
	vim.cmd('highlight link Pmenu Visual')

	vim.cmd('highlight clear VertSplit')
	vim.cmd('highlight link Vertsplit LineNr')
end

return colors
