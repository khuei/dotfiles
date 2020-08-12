if exists("g:loaded_focus") || &compatible
	finish
endif
let g:loaded_focus = 1

if has('autocmd')
	augroup Focus
		autocmd!
		autocmd BufEnter,FocusGained,VimEnter,WinEnter * set winhighlight=
		autocmd FocusLost,WinLeave * set winhighlight=CursorLineNr:LineNr,StatusLine:LineNr,EndOfBuffer:ColorColumn,IncSearch:ColorColumn,Normal:ColorColumn,NormalNC:ColorColumn,SignColumn:ColorColumn

		autocmd BufEnter,InsertLeave,VimEnter * setlocal cursorline
		autocmd BufLeave,InsertEnter * setlocal nocursorline

		autocmd BufEnter,FocusGained,VimEnter,WinEnter * set list
		autocmd BufLeave,FocusLost,WinLeave * set nolist

		if has('syntax')
			autocmd BufEnter,FocusGained,VimEnter,WinEnter * execute 'ownsyntax ' . (&ft)
			autocmd BufLeave,FocusLost,WinLeave * ownsyntax off
		endif
	augroup END
endif