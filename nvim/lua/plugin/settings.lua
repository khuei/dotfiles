local settings = {}

if vim.fn.has('autocmd') == 1 then
	vim.cmd([[filetype plugin indent on]])
end

if vim.fn.has('syntax') and vim.fn.exists('g:syntax_on') == 0 then
	vim.cmd([[syntax on]])
end

vim.api.nvim_set_option('mouse', 'a')

vim.api.nvim_set_option('autoread', true)

vim.api.nvim_set_option('hidden', true)

if vim.api.nvim_get_option('history') < 10000 then
	vim.api.nvim_set_option('history', 10000)
end

if vim.api.nvim_get_option('tabpagemax') < 50 then
	vim.api.nvim_set_option('tabpagemax', 50)
end

vim.api.nvim_set_option('updatetime', 100)

vim.api.nvim_set_option('ttimeout', true)
vim.api.nvim_set_option('ttimeoutlen', 100)

vim.api.nvim_set_option('scrolloff', 1)
vim.api.nvim_set_option('sidescrolloff', 5)

vim.api.nvim_buf_set_option(0, 'autoindent', true)
vim.api.nvim_set_option('backspace', 'indent,start,eol')
vim.api.nvim_set_option('smarttab', true)

vim.api.nvim_buf_set_option(0, 'tabstop', 8)
vim.api.nvim_buf_set_option(0, 'softtabstop', 8)
vim.api.nvim_buf_set_option(0, 'shiftwidth', 8)
vim.api.nvim_set_option('shiftround', true)
vim.api.nvim_buf_set_option(0, 'expandtab', false)
vim.api.nvim_buf_set_option(0, 'copyindent', true)
vim.api.nvim_buf_set_option(0, 'preserveindent', true)

vim.api.nvim_win_set_option(0, 'number', true)
vim.api.nvim_win_set_option(0, 'relativenumber', true)

vim.api.nvim_set_option('incsearch', true)

if vim.fn.exists('&inccommand') == 1 then
	vim.api.nvim_set_option('inccommand', 'split')
end

if vim.fn.has('showcmd') == 1 then
	vim.api.nvim_set_option('showcmd', false)
end

vim.api.nvim_set_option('completeopt', 'menuone,noinsert,noselect')

if vim.fn.exists('&wildmode') == 1 then
	vim.api.nvim_set_option('wildmenu', true)
end

vim.api.nvim_set_option('splitbelow', true)
vim.api.nvim_set_option('splitright', true)

if vim.fn.has('statusline') == 1 then
	vim.api.nvim_set_option('statusline', ' '
		.. '%<'
		.. '%F '
		.. '%m'
		.. '%r'
		.. '%y'
		.. '%w'
		.. '%='
		.. 'L: '
		.. '%l/%L '
		.. 'C: %c '
	)
	vim.api.nvim_set_option('laststatus', 2)
	vim.api.nvim_set_option('ruler', true)
end

if vim.fn.has('folding') == 1 then
	vim.api.nvim_set_option('fillchars', 'diff:∙,eob: ,fold:·,vert:┃')
	vim.api.nvim_set_option('foldmethod', 'indent')
	vim.api.nvim_set_option('foldlevelstart', 99)
end

if os.getenv('TERM') == 'linux' then
	vim.api.nvim_set_option('guicursor', '')
end

if vim.fn.has('termguicolors') == 1 then
	vim.api.nvim_set_option('termguicolors', true)
end

vim.api.nvim_set_option('shortmess', 'AIOTacot')

vim.api.nvim_win_set_option(0, 'list', true)
vim.api.nvim_set_option('listchars',
'extends:»,nbsp:ø,precedes:«,tab:▷┅,trail:•')

local winhighlight_blurred = table.concat({
	'CursorLineNr:LineNr',
	'StatusLine:LineNr',
	'EndOfBuffer:ColorColumn',
	'IncSearch:ColorColumn',
	'Normal:ColorColumn',
	'NormalNC:ColorColumn',
	'SignColumn:ColorColumn'
}, ',')

function settings.buf_enter()
	vim.api.nvim_win_set_option(0, 'winhighlight', '')
end

function settings.focus_gained()
	vim.api.nvim_win_set_option(0, 'winhighlight', '')
end

function settings.focus_lost()
	vim.api.nvim_win_set_option(0, 'winhighlight', winhighlight_blurred)
end

function settings.insert_enter()
	vim.api.nvim_win_set_option(0, 'cursorline', false)
end

function settings.insert_leave()
	vim.api.nvim_win_set_option(0, 'cursorline', true)
end

function settings.vim_enter()
	vim.api.nvim_win_set_option(0, 'cursorline', true)
	vim.api.nvim_win_set_option(0, 'winhighlight', '')
end

function settings.win_enter()
	vim.api.nvim_win_set_option(0, 'cursorline', true)
	vim.api.nvim_win_set_option(0, 'winhighlight', '')
end

function settings.win_leave()
	vim.api.nvim_win_set_option(0, 'cursorline', false)
	vim.api.nvim_win_set_option(0, 'winhighlight', winhighlight_blurred)
end

return settings
