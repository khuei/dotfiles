vim.loader.enable()

-----------------------------------------------------------
--------------------- Options -----------------------------
-----------------------------------------------------------

vim.cmd([[filetype plugin indent on]])

vim.cmd([[syntax on]])
vim.opt.termguicolors = true

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

vim.bo.autoindent = true
vim.opt.backspace = { 'indent', 'start', 'eol' }
vim.opt.smarttab = true

vim.bo.tabstop = 8
vim.bo.softtabstop = 8
vim.bo.shiftwidth = 8
vim.opt.shiftround = true
vim.bo.expandtab = false
vim.bo.copyindent = true
vim.bo.preserveindent = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.incsearch = true

vim.opt.inccommand = 'split'

vim.opt.showcmd = false

vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }

vim.opt.wildmenu = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.statusline = ' '
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

vim.wo.foldmethod = 'indent'
vim.opt.foldlevelstart = 99

if os.getenv('TERM') == 'linux' then
	vim.opt.guicursor = ''
end

vim.opt.shortmess = 'AIOTacot'

vim.wo.list = true
vim.opt.listchars = {
	extends = '»',
	nbsp = 'ø',
	precedes = '«',
	tab = '▷┅',
	trail = '•'
}

-----------------------------------------------------------
------------------- Autocommands --------------------------
-----------------------------------------------------------

local winhighlight_blurred = table.concat({
	'CursorLineNr:LineNr',
	'StatusLine:LineNr',
	'EndOfBuffer:ColorColumn',
	'IncSearch:ColorColumn',
	'Normal:SignColumn',
	'NormalNC:SignColumn',
	'Comment:SignColumn',
	'Keyword:SignColumn',
	'SignColumn:ColorColumn',
	'WinSeparator:ColorColumn',
	'VertSplit:ColorColumn',
	'Underlined:SignColumn',
	'SnippetTabstop:SignColumn',
	'@lsp.mod.deprecated:SignColumn',
	'@lsp.type.class:SignColumn',
	'@lsp.type.comment:SignColumn',
	'@lsp.type.decorator:SignColumn',
	'@lsp.type.enum:SignColumn',
	'@lsp.type.enumMember:SignColumn',
	'@lsp.type.event:SignColumn',
	'@lsp.type.function:SignColumn',
	'@lsp.type.interface:SignColumn',
	'@lsp.type.keyword:SignColumn',
	'@lsp.type.macro:SignColumn',
	'@lsp.type.method:SignColumn',
	'@lsp.type.modifier:SignColumn',
	'@lsp.type.namespace:SignColumn',
	'@lsp.type.number:SignColumn',
	'@lsp.type.operator:SignColumn',
	'@lsp.type.parameter:SignColumn',
	'@lsp.type.property:SignColumn',
	'@lsp.type.regexp:SignColumn',
	'@lsp.type.string:SignColumn',
	'@lsp.type.struct:SignColumn',
	'@lsp.type.type:SignColumn',
	'@lsp.type.typeParameter:SignColumn',
	'@lsp.type.variable:SignColumn',
	'@lsp:SignColumn',
	'DiagnosticDeprecated:SignColumn',
	'DiagnosticError:SignColumn',
	'DiagnosticFloatingError:SignColumn',
	'DiagnosticFloatingHint:SignColumn',
	'DiagnosticFloatingInfo:SignColumn',
	'DiagnosticFloatingOk:SignColumn',
	'DiagnosticFloatingWarn:SignColumn',
	'DiagnosticHint:SignColumn',
	'DiagnosticInfo:SignColumn',
	'DiagnosticOk:SignColumn',
	'DiagnosticSignError:SignColumn',
	'DiagnosticSignHint:SignColumn',
	'DiagnosticSignInfo:SignColumn',
	'DiagnosticSignOk:SignColumn',
	'DiagnosticSignWarn:SignColumn',
	'DiagnosticUnderlineError:SignColumn',
	'DiagnosticUnderlineHint:SignColumn',
	'DiagnosticUnderlineInfo:SignColumn',
	'DiagnosticUnderlineOk:SignColumn',
	'DiagnosticUnderlineWarn:SignColumn',
	'DiagnosticUnnecessary:SignColumn',
	'DiagnosticVirtualLinesError:SignColumn',
	'DiagnosticVirtualLinesHint:SignColumn',
	'DiagnosticVirtualLinesInfo:SignColumn',
	'DiagnosticVirtualLinesOk:SignColumn',
	'DiagnosticVirtualLinesWarn:SignColumn',
	'DiagnosticVirtualTextError:SignColumn',
	'DiagnosticVirtualTextHint:SignColumn',
	'DiagnosticVirtualTextInfo:SignColumn',
	'DiagnosticVirtualTextOk:SignColumn',
	'DiagnosticVirtualTextWarn:SignColumn',
	'DiagnosticWarn:SignColumn',
	'LspCodeLens:SignColumn',
	'LspCodeLensSeparator:SignColumn',
	'LspInlayHint:SignColumn',
	'LspReferenceRead:SignColumn',
	'LspReferenceTarget:SignColumn',
	'LspReferenceText:SignColumn',
	'LspReferenceWrite:SignColumn',
	'LspSignatureActiveParameter:SignColumn',
}, ',')

local highlight_autocmd = vim.api.nvim_create_augroup("Settings", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter", "WinEnter", "BufEnter" }, {
	callback = function()
		vim.wo.cursorline = true
		vim.wo.winhighlight = ''
		local filetype = vim.bo.filetype
		vim.cmd("ownsyntax " .. filetype)
	end,
	group = highlight_autocmd
})

vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave", "BufLeave" }, {
	callback = function()
		vim.wo.cursorline = false
		vim.wo.winhighlight = winhighlight_blurred
		vim.cmd([[ownsyntax off]])
	end,
	group = highlight_autocmd
})

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.wo.cursorline = false
	end,
	group = highlight_autocmd
})

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.wo.cursorline = true
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
----------------------- Netrw -----------------------------
-----------------------------------------------------------

vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_show_hidden = 1
vim.g.netrw_winsize = 20
vim.g.netrw_banner = 0

vim.api.nvim_set_keymap('n', '<Leader>e', ':Lexplore<CR>', { noremap = true, silent = true })


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
------------------- Language Servers ----------------------
-----------------------------------------------------------

vim.cmd([[packadd lspconfig]])

local lspconfig = require('lspconfig')
local coq = require('coq')

if vim.fn.executable('bash-language-server') == 1 then
	lspconfig.bashls.setup({
		coq.lsp_ensure_capabilities({})
	})
end

if vim.fn.executable('clangd') == 1 then
	lspconfig.clangd.setup({
		coq.lsp_ensure_capabilities({})
	})
end

if vim.fn.executable('gopls') == 1 then
	lspconfig.gopls.setup({
		coq.lsp_ensure_capabilities({})
	})
end

if vim.fn.executable('ts_ls') == 1 then
	lspconfig.ts_ls.setup({
		coq.lsp_ensure_capabilities({})
	})
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

if vim.fn.executable('lua-language-server') == 1 then
	lspconfig.lua_ls.setup({
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
		coq.lsp_ensure_capabilities({})
	})
end

if vim.fn.executable('pyright-langserver') == 1 then
	lspconfig.pyright.setup({
		coq.lsp_ensure_capabilities({})
	})
elseif vim.fn.executable('pyls') == 1 then
	lspconfig.pyls.setup({
		coq.lsp_ensure_capabilities({})
	})
end

if vim.fn.executable('typescript-language-server') == 1 then
	lspconfig.ts_ls.setup({
		coq.lsp_ensure_capabilities({})
	})
end

if vim.fn.executable('rust-analyzer') == 1 then
	lspconfig.rust_analyzer.setup({
		coq.lsp_ensure_capabilities({})
	})
elseif vim.fn.executable('rls') == 1 then
	lspconfig.rls.setup({
		coq.lsp_ensure_capabilities({})
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

vim.diagnostic.config {
	virtual_text = true,
	underline = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "x",
			[vim.diagnostic.severity.WARN] = "w",
			[vim.diagnostic.severity.INFO] = "i",
			[vim.diagnostic.severity.HINT] = "h",
		},
	},
}
