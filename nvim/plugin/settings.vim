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
	augroup cursorline
		autocmd!
		autocmd BufEnter,InsertLeave,VimEnter * setlocal cursorline
		autocmd BufLeave,InsertEnter * setlocal nocursorline
	augroup END

	augroup winhighlight
		autocmd!
		autocmd BufEnter,FocusGained,VimEnter,WinEnter * set winhighlight=
		autocmd FocusLost,WinLeave * set winhighlight=CursorLineNr:LineNr,StatusLine:LineNr,EndOfBuffer:ColorColumn,IncSearch:ColorColumn,Normal:ColorColumn,NormalNC:ColorColumn,SignColumn:ColorColumn
	augroup END
endif
