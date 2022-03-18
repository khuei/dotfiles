vim.cmd([[filetype plugin indent on]])

vim.api.nvim_set_option('mouse', 'a')

vim.api.nvim_set_option('autoread', true)

vim.api.nvim_set_option('hidden', true)

vim.api.nvim_set_option('history', 10000)

vim.api.nvim_set_option('tabpagemax', 50)

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

vim.api.nvim_set_option('inccommand', 'split')

vim.api.nvim_set_option('showcmd', false)

vim.api.nvim_set_option('completeopt', 'menuone,noinsert,noselect')

vim.api.nvim_set_option('wildmenu', true)

vim.api.nvim_set_option('splitbelow', true)
vim.api.nvim_set_option('splitright', true)

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
vim.api.nvim_set_option('laststatus', 3)
vim.api.nvim_set_option('ruler', true)

vim.opt.fillchars = {
	stl = ' ',
	stlnc = ' ',
	diff = '∙',
	eob = ' ',
	fold = '·',
	horiz = '━',
	horizup = '┻',
	horizdown = '┳',
	vert = '┃',
	vertleft = '┫',
	vertright = '┣',
	verthoriz = '╋'
}

vim.api.nvim_win_set_option(0, 'foldmethod', 'indent')
vim.api.nvim_set_option('foldlevelstart', 99)

if os.getenv('TERM') == 'linux' then
	vim.api.nvim_set_option('guicursor', '')
end

vim.api.nvim_set_option('termguicolors', true)

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

local autocmd = vim.api.nvim_create_augroup("Settings", { clear = true })

vim.api.nvim_create_autocmd({"BufEnter", "FocusGained"}, {
	callback = function()
		vim.api.nvim_win_set_option(0, 'winhighlight', '')
	end,
	group = autocmd
})

vim.api.nvim_create_autocmd("FocusLost", {
	callback = function()
		vim.api.nvim_win_set_option(0, 'winhighlight', winhighlight_blurred)
	end,
	group = autocmd
})

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.api.nvim_win_set_option(0, 'cursorline', false)
	end,
	group = autocmd
})

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.api.nvim_win_set_option(0, 'cursorline', true)
	end,
	group = autocmd
})

vim.api.nvim_create_autocmd({"VimEnter", "WinEnter"}, {
	callback = function()
		vim.api.nvim_win_set_option(0, 'cursorline', true)
		vim.api.nvim_win_set_option(0, 'winhighlight', '')
	end,
	group = autocmd
})

vim.api.nvim_create_autocmd("WinLeave", {
	callback = function()
		vim.api.nvim_win_set_option(0, 'cursorline', false)
		vim.api.nvim_win_set_option(0, 'winhighlight', winhighlight_blurred)
	end,
	group = autocmd
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank { timeout = 200 }
	end,
	group = autocmd
})
