vim.loader.enable()

-----------------------------------------------------------
--------------------- Options -----------------------------
-----------------------------------------------------------

vim.cmd([[filetype plugin indent on]])

vim.opt.mouse = 'a'
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.history = 10000
vim.opt.tabpagemax = 50
vim.opt.updatetime = 100
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5
vim.opt_local.autoindent = true
vim.opt.backspace = 'indent,start,eol'
vim.opt.smarttab = true
vim.opt_local.tabstop = 8
vim.opt_local.softtabstop = 8
vim.opt_local.shiftwidth = 8
vim.opt.shiftround = true
vim.opt_local.expandtab = false
vim.opt_local.copyindent = true
vim.opt_local.preserveindent = true
vim.opt_local.number = true
vim.opt_local.relativenumber = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'
vim.opt.showcmd = false
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.wildmenu = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.statusline = (
	' '
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
vim.opt.laststatus = 3
vim.opt.ruler = true
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
vim.opt_local.foldmethod = 'syntax'
vim.opt.foldlevelstart = 99

if os.getenv('TERM') == 'linux' then
	vim.opt.guicursor = ''
end

vim.opt.termguicolors = true
vim.opt.shortmess = 'AIOTacot'
vim.opt_local.list = true
vim.opt.listchars = (
	'extends:»,'
	.. 'nbsp:ø,'
	.. 'precedes:«,'
	.. 'tab:▷┅,'
	.. 'trail:•'
)

-----------------------------------------------------------
------------------- Autocommands --------------------------
-----------------------------------------------------------

local winhighlight_blurred = table.concat({
	'CursorLineNr:LineNr',
	'StatusLine:LineNr',
	'EndOfBuffer:ColorColumn',
	'IncSearch:ColorColumn',
	'Normal:ColorColumn',
	'NormalNC:ColorColumn',
	'SignColumn:ColorColumn'
}, ',')

local highlight_autocmd = vim.api.nvim_create_augroup("Settings", { clear = true })

vim.api.nvim_create_autocmd({"BufEnter", "FocusGained"}, {
	callback = function()
		vim.opt_local.winhighlight = ''
	end,
	group = highlight_autocmd
})

vim.api.nvim_create_autocmd("FocusLost", {
	callback = function()
		vim.opt_local.winhighlight = winhighlight_blurred
	end,
	group = highlight_autocmd
})

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.opt_local.cursorline = false
	end,
	group = highlight_autocmd
})

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.opt_local.cursorline = true
	end,
	group = highlight_autocmd
})

vim.api.nvim_create_autocmd({"VimEnter", "WinEnter"}, {
	callback = function()
		vim.opt_local.cursorline = true
		vim.opt_local.winhighlight = ''
	end,
	group = highlight_autocmd
})

vim.api.nvim_create_autocmd("WinLeave", {
	callback = function()
		vim.opt_local.cursorline = false
		vim.opt_local.winhighlight = winhighlight_blurred
	end,
	group = highlight_autocmd
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank { timeout = 200 }
	end,
	group = highlight_autocmd
})

local scheme_autocmd = vim.api.nvim_create_augroup("Color", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.cmd('highlight Comment cterm=italic gui=italic')

		local conceal_term_fg
		local conceal_gui_fg

		if vim.opt.background:get() == 'dark' then
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
	end,
	group = scheme_autocmd
})

vim.api.nvim_create_autocmd({"VimEnter", "FocusGained"}, {
	callback = function()
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
			'/nvim/colors/base16-' .. config[0] .. '.lua')
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
	end,
	group = scheme_autocmd
})

-----------------------------------------------------------
---------------------- Mappings ---------------------------
-----------------------------------------------------------

vim.api.nvim_set_var('mapleader', ' ')

vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

vim.api.nvim_set_keymap('n', '<Leader>n', '<cmd>nohlsearch<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>zz', [[<cmd>%s/\s\+$//e<CR>]],
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Up>', '<cmd>cprevious<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Down>', '<cmd>cnext<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Left>', '<cmd>cpfile<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Right>', '<cmd>cnfile<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<S-Up>', '<cmd>lprevious<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<S-Down>', '<cmd>lnext<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<S-Left>', '<cmd>lpfile<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<S-Right>', '<cmd>lnfile<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'k', [[(v:count > 2 ? "m'" . v:count : '') . 'k']],
{ noremap = true, expr = true })

vim.api.nvim_set_keymap('n', 'j', [[(v:count > 2 ? "m'" . v:count : '') . 'j']],
{ noremap = true, expr = true })

vim.api.nvim_set_keymap('c', '<Tab>',
[[getcmdtype() =~ '[/?]' ? '<CR>/<C-r>/' : '<C-z>']],
{ noremap = true, expr = true })

vim.api.nvim_set_keymap('c', '<S-Tab>',
[[getcmdtype() =~ '[/?]' ?  '<CR>?<C-r>/' : '<S-Tab>']],
{ noremap = true, expr = true })

vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
vim.api.nvim_set_keymap('t', '<C-h>', [[<C-\><C-n><C-w>h]], { noremap = true })
vim.api.nvim_set_keymap('t', '<C-j>', [[<C-\><C-n><C-w>j]], { noremap = true })
vim.api.nvim_set_keymap('t', '<C-k>', [[<C-\><C-n><C-w>k]], { noremap = true })
vim.api.nvim_set_keymap('t', '<C-l>', [[<C-\><C-n><C-w>l]], { noremap = true })

-----------------------------------------------------------
-------------------- Command-T ----------------------------
-----------------------------------------------------------

vim.g.CommandTPreferredImplementation = 'ruby'
vim.g.CommandTMaxFiles = 200000

vim.cmd([[packadd command-t]])

vim.keymap.set('n', '<Leader>b', '<Plug>(CommandTBuffer)')
vim.keymap.set('n', '<Leader>j', '<Plug>(CommandTJump)')
vim.keymap.set('n', '<Leader>t', '<Plug>(CommandT)')

-----------------------------------------------------------
------------------------ COQ ------------------------------
-----------------------------------------------------------

vim.g.coq_settings = {
	xdg = false,
	auto_start = 'shut-up',
	display = {
		pum = {
			fast_close = false,
			source_context = {"[", "]"},
		},
		preview = {
			border = "single",
			positions = {
				east = 1,
				south = 2,
				north = 3,
				west = 4,
			},
		},
		ghost_text = {
			enabled = true,
			context = {"", ""},
		},
		icons = {
			mode = "none",
		}
	},
	keymap = {
		recommended = true,
		jump_to_mark = "<C-e><CR>",
	}
}

vim.cmd([[packadd coq]])
vim.cmd([[packadd artifacts]])

-----------------------------------------------------------
------------------- Treesitter ----------------------------
-----------------------------------------------------------

vim.cmd([[packadd treesitter]])

require('nvim-treesitter.configs').setup {
	highlight = {
		enable = true
	},
}

-----------------------------------------------------------
------------------- Language Servers ----------------------
-----------------------------------------------------------

vim.cmd([[packadd lspconfig]])

if vim.fn.executable('bash-language-server') == 1 then
	require('lspconfig').bashls.setup({
		require('coq').lsp_ensure_capabilities({})
	})
end

if vim.fn.executable('clangd') == 1 then
	require('lspconfig').clangd.setup({
		require('coq').lsp_ensure_capabilities({})
	})
end

if vim.fn.executable('gopls') == 1 then
	require('lspconfig').gopls.setup({
		require('coq').lsp_ensure_capabilities({})
	})
end

if vim.fn.executable('ts_ls') == 1 then
	require('lspconfig').ts_ls.setup({
		require('coq').lsp_ensure_capabilities({})
	})
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

if vim.fn.executable('lua-language-server') == 1 then
	require('lspconfig').lua_ls.setup({
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
					path = runtime_path,
				},
				diagnostics = {
					globals = {'vim'},
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
		require('coq').lsp_ensure_capabilities({})
	})
end

if vim.fn.executable('pyright-langserver') == 1 then
	require('lspconfig').pyright.setup({
		require('coq').lsp_ensure_capabilities({})
	})
elseif vim.fn.executable('pyls') == 1 then
	require('lspconfig').pyls.setup({
		require('coq').lsp_ensure_capabilities({})
	})
end

if vim.fn.executable('rust-analyzer') == 1 then
	require('lspconfig').rust_analyzer.setup({
		require('coq').lsp_ensure_capabilities({})
	})
elseif vim.fn.executable('rls') == 1 then
	require('lspconfig').rls.setup({
		require('coq').lsp_ensure_capabilities({})
	})
end

vim.api.nvim_set_keymap('n', '<Leader>ds',
'<cmd>lua vim.diagnostic.open_float()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>dn',
'<cmd>lua vim.diagnostic.goto_next()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>dN',
'<cmd>lua vim.diagnostic.goto_prev()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'K',
'<cmd>lua vim.lsp.buf.hover()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'g0',
'<cmd>lua vim.lsp.buf.document_symbol()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'gW',
'<cmd>lua vim.lsp.buf.workspace_symbol()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'gd',
'<cmd>lua vim.lsp.buf.declaration()<CR>',
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'gr',
'<cmd>lua vim.lsp.buf.references()<CR>',
{ noremap = true, silent = true })

vim.fn.sign_define('DiagnosticSignError', { text = 'x', texthl =
'DiagnosticSignError', numhl = 'DiagnosticSignError' })

vim.fn.sign_define('DiagnosticSignWarn', { text = 'w', texthl =
'DiagnosticSignWarn', numhl = 'DiagnosticSignWarn' })

vim.fn.sign_define('DiagnosticSignInfo', { texthl =
'DiagnosticSignInfo', text = 'i', numhl = 'DiagnosticSignInfo' })

vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', text
= 'h', numhl = 'DiagnosticSignHint' })
