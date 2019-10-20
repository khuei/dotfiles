if exists('g:loaded_settings') || &compatible
	finish
endif
let g:loaded_settings = 1

scriptencoding utf-8

if has('autocmd')
	filetype plugin indent on
endif

if has('syntax') && !exists('g:syntax_on')
	syntax on
endif

if &history < 10000
	set history=10000
endif

set updatetime=100

set ttimeout
set ttimeoutlen=100

set autoindent
set backspace=indent,start,eol

set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab

if !&scrolloff
	set scrolloff=1
endif

if !&sidescrolloff
	set sidescrolloff=5
endif

set number
set relativenumber

if $TERM == 'linux'
	set guicursor=
else
	set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
endif

if exists('&inccommand')
	set inccommand=split
endif

if has('showcmd')
	set noshowcmd
endif

if has('statusline')
	set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P
	set laststatus=2
	set ruler
endif

set list
set listchars+=extends:»
set listchars+=nbsp:ø
set listchars+=precedes:«
set listchars+=tab:▷┅
set listchars+=trail:•

if has('folding')
	set fillchars=diff:∙
	set fillchars+=eob:\ |
	set fillchars+=fold:·
	set fillchars+=vert:┃

	set foldmethod=indent
	set foldlevelstart=99
endif

set completeopt=menuone
set completeopt+=noinsert
set completeopt+=noselect

set shortmess=I
set shortmess+=c

set splitbelow
set splitright

if has('termguicolors')
	set termguicolors
endif

if exists('&wildmode')
	set wildmenu
	set wildcharm=<C-z>
endif
