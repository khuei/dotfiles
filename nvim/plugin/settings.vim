if exists('g:loaded_settings') || &compatible
	finish
endif
let g:loaded_settings = 1

if has('autocmd')
	filetype plugin indent on
endif

if has('syntax') && !exists('g:syntax_on')
	syntax on
endif

set autoread

set hidden

if &history < 10000
	set history=10000
endif

if &tabpagemax < 50
	set tabpagemax=50
endif

set updatetime=100

set ttimeout
set ttimeoutlen=100

set autoindent
set backspace=indent,start,eol
set smarttab

set tabstop=8
set softtabstop=8
set shiftwidth=8
set shiftround
set noexpandtab
set copyindent
set preserveindent

if !&scrolloff
	set scrolloff=1
endif

if !&sidescrolloff
	set sidescrolloff=5
endif

set number
set relativenumber

set incsearch

if exists('&inccommand')
	set inccommand=split
endif

if has('showcmd')
	set noshowcmd
endif

set completeopt=menuone
set completeopt+=noinsert
set completeopt+=noselect

if exists('&wildmode')
	set wildmenu
	set wildcharm=<C-z>
endif

set splitbelow
set splitright

if has('statusline')
	set statusline=%<\ %F\ %m%r%y%w%=\ L:\ \%l\/\%L\ C:\ \%c\ |
	set laststatus=2
	set ruler
endif

if has('folding')
	set fillchars=diff:∙
	set fillchars+=eob:\ |
	set fillchars+=fold:·
	set fillchars+=vert:┃

	set foldmethod=indent
	set foldlevelstart=99
endif

if $TERM =~# '^linux'
	set guicursor=
endif

if has('termguicolors')
	set termguicolors
endif

set shortmess+=A
set shortmess+=I
set shortmess+=O
set shortmess+=T
set shortmess+=a
set shortmess+=c
set shortmess+=o
set shortmess+=t

set list
set listchars+=extends:»
set listchars+=nbsp:ø
set listchars+=precedes:«
set listchars+=tab:▷┅
set listchars+=trail:•

if has('autocmd')
	augroup autocmds
		autocmd!
		autocmd BufEnter * lua require('plugin.autocmds').buf_enter()
		autocmd FocusGained * lua require('plugin.autocmds').focus_gained()
		autocmd FocusLost * lua require('plugin.autocmds').focus_lost()
		autocmd InsertEnter * lua require('plugin.autocmds').insert_enter()
		autocmd InsertLeave * lua require('plugin.autocmds').insert_leave()
		autocmd VimEnter * lua require('plugin.autocmds').vim_enter()
		autocmd WinEnter * lua require('plugin.autocmds').win_enter()
		autocmd WinLeave * lua require('plugin.autocmds').win_leave()

		autocmd TextYankPost * lua vim.highlight.on_yank{timeout=200}
	augroup END
endif
