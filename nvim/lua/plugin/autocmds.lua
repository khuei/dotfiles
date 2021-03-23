local autocmds = {}

local winhighlight_blurred = table.concat({
	'CursorLineNr:LineNr',
	'StatusLine:LineNr',
	'EndOfBuffer:ColorColumn',
	'IncSearch:ColorColumn',
	'Normal:ColorColumn',
	'NormalNC:ColorColumn',
	'SignColumn:ColorColumn'
}, ',')

local focus_window = function()
	vim.api.nvim_win_set_option(0, 'winhighlight', '')
end

local blur_window = function()
	vim.api.nvim_win_set_option(0, 'winhighlight', winhighlight_blurred)
end

local set_cursorline = function(active)
	vim.api.nvim_win_set_option(0, 'cursorline', active)
end

autocmds.buf_enter = function()
	focus_window()
end

autocmds.focus_gained = function()
	focus_window()
end

autocmds.focus_lost = function()
	blur_window()
end

autocmds.insert_enter = function()
	set_cursorline(false)
end

autocmds.insert_leave = function()
	set_cursorline(true)
end

autocmds.vim_enter = function()
	set_cursorline(true)
	focus_window()
end

autocmds.win_enter = function()
	set_cursorline(true)
	focus_window()
end

autocmds.win_leave = function()
	set_cursorline(false)
	blur_window()
end

return autocmds
