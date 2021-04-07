local colorscheme = {}

--- GUI color definitions
local gui00 = '262626'
local base16_gui00 = '262626'
local gui01 = '3a3a3a'
local base16_gui01 = '3a3a3a'
local gui02 = '4e4e4e'
local base16_gui02 = '4e4e4e'
local gui03 = '8a8a8a'
local base16_gui03 = '8a8a8a'
local gui04 = '949494'
local base16_gui04 = '949494'
local gui05 = 'dab997'
local base16_gui05 = 'dab997'
local gui06 = 'd5c4a1'
local base16_gui06 = 'd5c4a1'
local gui07 = 'ebdbb2'
local base16_gui07 = 'ebdbb2'
local gui08 = 'd75f5f'
local base16_gui08 = 'd75f5f'
local gui09 = 'ff8700'
local base16_gui09 = 'ff8700'
local gui0A = 'ffaf00'
local base16_gui0A = 'ffaf00'
local gui0B = 'afaf00'
local base16_gui0B = 'afaf00'
local gui0C = '85ad85'
local base16_gui0C = '85ad85'
local gui0D = '83adad'
local base16_gui0D = '83adad'
local gui0E = 'd485ad'
local base16_gui0E = 'd485ad'
local gui0F = 'd65d0e'
local base16_gui0F = 'd65d0e'

--- Terminal color definitions
local cterm00 = '00'
local base16_cterm00 = '00'
local cterm03 = '08'
local base16_cterm03 = '08'
local cterm05 = '07'
local base16_cterm05 = '07'
local cterm07 = '15'
local base16_cterm07 = '15'
local cterm08 = '01'
local base16_cterm08 = '01'
local cterm0A = '03'
local base16_cterm0A = '03'
local cterm0B = '02'
local base16_cterm0B = '02'
local cterm0C = '06'
local base16_cterm0C = '06'
local cterm0D = '04'
local base16_cterm0D = '04'
local cterm0E = '05'
local base16_cterm0E = '05'
local cterm01 = '10'
local base16_cterm01 = '10'
local cterm02 = '11'
local base16_cterm02 = '11'
local cterm04 = '12'
local base16_cterm04 = '12'
local cterm06 = '13'
local base16_cterm06 = '13'
local cterm09 = '09'
local base16_cterm09 = '09'
local cterm0F = '14'
local base16_cterm0F = '14'

--- Neovim terminal colours
local terminal_color_0 = '#262626'
local terminal_color_1 = '#d75f5f'
local terminal_color_2 = '#afaf00'
local terminal_color_3 = '#ffaf00'
local terminal_color_4 = '#83adad'
local terminal_color_5 = '#d485ad'
local terminal_color_6 = '#85ad85'
local terminal_color_7 = '#dab997'
local terminal_color_8 = '#8a8a8a'
local terminal_color_9 = '#d75f5f'
local terminal_color_10 = '#afaf00'
local terminal_color_11 = '#ffaf00'
local terminal_color_12 = '#83adad'
local terminal_color_13 = '#d485ad'
local terminal_color_14 = '#85ad85'
local terminal_color_15 = '#ebdbb2'
local terminal_color_background = terminal_color_0
local terminal_color_foreground = terminal_color_5
if vim.api.nvim_get_option('background') == 'light' then
	local terminal_color_background = terminal_color_7
	local terminal_color_foreground = terminal_color_2
end

--- Theme setup
vim.cmd('hi clear')
vim.cmd('syntax reset')
local colors_name = 'base16-gruvbox-dark-pale'

--- Highlighting function
--- Optional variables are attributes and guisp
local hi = function(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
	if guifg ~= nil and guifg ~= '' then
		vim.cmd('hi ' .. group .. ' guifg=#' .. guifg)
	end
	if guibg ~= nil and guibg ~= '' then
		vim.cmd('hi ' .. group .. ' guibg=#' .. guibg)
	end
	if ctermfg ~= nil and ctermfg ~= '' then
		vim.cmd('hi ' .. group .. ' ctermfg=' .. ctermfg)
	end
	if ctermbg ~= nil and ctermbg ~= '' then
		vim.cmd('hi ' .. group .. ' ctermbg=' .. ctermbg)
	end
	if attr ~= nil and attr ~= '' then
		vim.cmd('hi ' .. group .. ' gui=' .. attr .. ' cterm=' .. attr)
	end
	if guisp ~= '' then
		vim.cmd('hi ' .. group .. ' guisp=#' .. guisp)
	end
end

colorscheme.setup = function()
	--- Vim editor colors
	hi('Normal', gui05, gui00, cterm05, cterm00, '', '')
	hi('Bold', '', '', '', '', 'bold', '')
	hi('Debug', gui08, '', cterm08, '', '', '')
	hi('Directory', gui0D, '', cterm0D, '', '', '')
	hi('Error', gui00, gui08, cterm00, cterm08, '', '')
	hi('ErrorMsg', gui08, gui00, cterm08, cterm00, '', '')
	hi('Exception', gui08, '', cterm08, '', '', '')
	hi('FoldColumn', gui0C, gui01, cterm0C, cterm01, '', '')
	hi('Folded', gui03, gui01, cterm03, cterm01, '', '')
	hi('IncSearch', gui01, gui09, cterm01, cterm09, 'none', '')
	hi('Italic', '', '', '', '', 'none', '')
	hi('Macro', gui08, '', cterm08, '', '', '')
	hi('MatchParen', '', gui03, '', cterm03, '', '')
	hi('ModeMsg', gui0B, '', cterm0B, '', '', '')
	hi('MoreMsg', gui0B, '', cterm0B, '', '', '')
	hi('Question', gui0D, '', cterm0D, '', '', '')
	hi('Search', gui01, gui0A, cterm01, cterm0A, '', '')
	hi('Substitute', gui01, gui0A, cterm01, cterm0A, 'none', '')
	hi('SpecialKey', gui03, '', cterm03, '', '', '')
	hi('TooLong', gui08, '', cterm08, '', '', '')
	hi('Underlined', gui08, '', cterm08, '', '', '')
	hi('Visual', '', gui02, '', cterm02, '', '')
	hi('VisualNOS', gui08, '', cterm08, '', '', '')
	hi('WarningMsg', gui08, '', cterm08, '', '', '')
	hi('WildMenu', gui08, gui0A, cterm08, '', '', '')
	hi('Title', gui0D, '', cterm0D, '', 'none', '')
	hi('Conceal', gui0D, gui00, cterm0D, cterm00, '', '')
	hi('Cursor', gui00, gui05, cterm00, cterm05, '', '')
	hi('NonText', gui03, '', cterm03, '', '', '')
	hi('LineNr', gui03, gui01, cterm03, cterm01, '', '')
	hi('SignColumn', gui03, gui01, cterm03, cterm01, '', '')
	hi('StatusLine', gui04, gui02, cterm04, cterm02, 'none', '')
	hi('StatusLineNC', gui03, gui01, cterm03, cterm01, 'none', '')
	hi('VertSplit', gui02, gui02, cterm02, cterm02, 'none', '')
	hi('ColorColumn', '', gui01, '', cterm01, 'none', '')
	hi('CursorColumn', '', gui01, '', cterm01, 'none', '')
	hi('CursorLine', '', gui01, '', cterm01, 'none', '')
	hi('CursorLineNr', gui04, gui01, cterm04, cterm01, '', '')
	hi('QuickFixLine', '', gui01, '', cterm01, 'none', '')
	hi('PMenu', gui05, gui01, cterm05, cterm01, 'none', '')
	hi('PMenuSel', gui01, gui05, cterm01, cterm05, '', '')
	hi('TabLine', gui03, gui01, cterm03, cterm01, 'none', '')
	hi('TabLineFill', gui03, gui01, cterm03, cterm01, 'none', '')
	hi('TabLineSel', gui0B, gui01, cterm0B, cterm01, 'none', '')

	--- Standard syntax highlighting
	hi('Boolean', gui09, '', cterm09, '', '', '')
	hi('Character', gui08, '', cterm08, '', '', '')
	hi('Comment', gui03, '', cterm03, '', '', '')
	hi('Conditional', gui0E, '', cterm0E, '', '', '')
	hi('Constant', gui09, '', cterm09, '', '', '')
	hi('Define', gui0E, '', cterm0E, '', 'none', '')
	hi('Delimiter', gui0F, '', cterm0F, '', '', '')
	hi('Float', gui09, '', cterm09, '', '', '')
	hi('Function', gui0D, '', cterm0D, '', '', '')
	hi('Identifier', gui08, '', cterm08, '', 'none', '')
	hi('Include', gui0D, '', cterm0D, '', '', '')
	hi('Keyword', gui0E, '', cterm0E, '', '', '')
	hi('Label', gui0A, '', cterm0A, '', '', '')
	hi('Number', gui09, '', cterm09, '', '', '')
	hi('Operator', gui05, '', cterm05, '', 'none', '')
	hi('PreProc', gui0A, '', cterm0A, '', '', '')
	hi('Repeat', gui0A, '', cterm0A, '', '', '')
	hi('Special', gui0C, '', cterm0C, '', '', '')
	hi('SpecialChar', gui0F, '', cterm0F, '', '', '')
	hi('Statement', gui08, '', cterm08, '', '', '')
	hi('StorageClass', gui0A, '', cterm0A, '', '', '')
	hi('String', gui0B, '', cterm0B, '', '', '')
	hi('Structure', gui0E, '', cterm0E, '', '', '')
	hi('Tag', gui0A, '', cterm0A, '', '', '')
	hi('Todo', gui0A, gui01, cterm0A, cterm01, '', '')
	hi('Type', gui0A, '', cterm0A, '', 'none', '')
	hi('Typedef', gui0A, '', cterm0A, '', '', '')

	--- C highlighting
	hi('cOperator', gui0C, '', cterm0C, '', '', '')
	hi('cPreCondit', gui0E, '', cterm0E, '', '', '')

	--- C# highlighting
	hi('csClass', gui0A, '', cterm0A, '', '', '')
	hi('csAttribute', gui0A, '', cterm0A, '', '', '')
	hi('csModifier', gui0E, '', cterm0E, '', '', '')
	hi('csType', gui08, '', cterm08, '', '', '')
	hi('csUnspecifiedStatement', gui0D, '', cterm0D, '', '', '')
	hi('csContextualStatement', gui0E, '', cterm0E, '', '', '')
	hi('csNewDecleration', gui08, '', cterm08, '', '', '')

	--- CSS highlighting
	hi('cssBraces', gui05, '', cterm05, '', '', '')
	hi('cssClassName', gui0E, '', cterm0E, '', '', '')
	hi('cssColor', gui0C, '', cterm0C, '', '', '')

	--- Diff highlighting
	hi('DiffAdd', gui0B, gui01, cterm0B, cterm01, '', '')
	hi('DiffChange', gui03, gui01, cterm03, cterm01, '', '')
	hi('DiffDelocale', gui08, gui01, cterm08, cterm01, '', '')
	hi('DiffText', gui0D, gui01, cterm0D, cterm01, '', '')
	hi('DiffAdded', gui0B, gui00, cterm0B, cterm00, '', '')
	hi('DiffFile', gui08, gui00, cterm08, cterm00, '', '')
	hi('DiffNewFile', gui0B, gui00, cterm0B, cterm00, '', '')
	hi('DiffLine', gui0D, gui00, cterm0D, cterm00, '', '')
	hi('DiffRemoved', gui08, gui00, cterm08, cterm00, '', '')

	--- Git highlighting
	hi('gitcommitOverflow', gui08, '', cterm08, '', '', '')
	hi('gitcommitSummary', gui0B, '', cterm0B, '', '', '')
	hi('gitcommitComment', gui03, '', cterm03, '', '', '')
	hi('gitcommitUntracked', gui03, '', cterm03, '', '', '')
	hi('gitcommitDiscarded', gui03, '', cterm03, '', '', '')
	hi('gitcommitSelected', gui03, '', cterm03, '', '', '')
	hi('gitcommitHeader', gui0E, '', cterm0E, '', '', '')
	hi('gitcommitSelectedType', gui0D, '', cterm0D, '', '', '')
	hi('gitcommitUnmergedType', gui0D, '', cterm0D, '', '', '')
	hi('gitcommitDiscardedType', gui0D, '', cterm0D, '', '', '')
	hi('gitcommitBranch', gui09, '', cterm09, '', 'bold', '')
	hi('gitcommitUntrackedFile', gui0A, '', cterm0A, '', '', '')
	hi('gitcommitUnmergedFile', gui08, '', cterm08, '', 'bold', '')
	hi('gitcommitDiscardedFile', gui08, '', cterm08, '', 'bold', '')
	hi('gitcommitSelectedFile', gui0B, '', cterm0B, '', 'bold', '')

	--- GitGutter highlighting
	hi('GitGutterAdd', gui0B, gui01, cterm0B, cterm01, '', '')
	hi('GitGutterChange', gui0D, gui01, cterm0D, cterm01, '', '')
	hi('GitGutterDelocale', gui08, gui01, cterm08, cterm01, '', '')
	hi('GitGutterChangeDelocale', gui0E, gui01, cterm0E, cterm01, '', '')

	--- HTML highlighting
	hi('htmlBold', gui0A, '', cterm0A, '', '', '')
	hi('htmlItalic', gui0E, '', cterm0E, '', '', '')
	hi('htmlEndTag', gui05, '', cterm05, '', '', '')
	hi('htmlTag', gui05, '', cterm05, '', '', '')

	--- JavaScript highlighting
	hi('javaScript', gui05, '', cterm05, '', '', '')
	hi('javaScriptBraces', gui05, '', cterm05, '', '', '')
	hi('javaScriptNumber', gui09, '', cterm09, '', '', '')
	--- pangloss/vim-javascript highlighting
	hi('jsOperator', gui0D, '', cterm0D, '', '', '')
	hi('jsStatement', gui0E, '', cterm0E, '', '', '')
	hi('jsReturn', gui0E, '', cterm0E, '', '', '')
	hi('jsThis', gui08, '', cterm08, '', '', '')
	hi('jsClassDefinition', gui0A, '', cterm0A, '', '', '')
	hi('jsFunction', gui0E, '', cterm0E, '', '', '')
	hi('jsFuncName', gui0D, '', cterm0D, '', '', '')
	hi('jsFuncCall', gui0D, '', cterm0D, '', '', '')
	hi('jsClassFuncName', gui0D, '', cterm0D, '', '', '')
	hi('jsClassMethodType', gui0E, '', cterm0E, '', '', '')
	hi('jsRegexpString', gui0C, '', cterm0C, '', '', '')
	hi('jsGlobalObjects', gui0A, '', cterm0A, '', '', '')
	hi('jsGlobalNodeObjects', gui0A, '', cterm0A, '', '', '')
	hi('jsExceptions', gui0A, '', cterm0A, '', '', '')
	hi('jsBuiltins', gui0A, '', cterm0A, '', '', '')

	--- Mail highlighting
	hi('mailQuoted1', gui0A, '', cterm0A, '', '', '')
	hi('mailQuoted2', gui0B, '', cterm0B, '', '', '')
	hi('mailQuoted3', gui0E, '', cterm0E, '', '', '')
	hi('mailQuoted4', gui0C, '', cterm0C, '', '', '')
	hi('mailQuoted5', gui0D, '', cterm0D, '', '', '')
	hi('mailQuoted6', gui0A, '', cterm0A, '', '', '')
	hi('mailURL', gui0D, '', cterm0D, '', '', '')
	hi('mailEmail', gui0D, '', cterm0D, '', '', '')

	--- Markdown highlighting
	hi('markdownCode', gui0B, '', cterm0B, '', '', '')
	hi('markdownError', gui05, gui00, cterm05, cterm00, '', '')
	hi('markdownCodeBlock', gui0B, '', cterm0B, '', '', '')
	hi('markdownHeadingDelimiter', gui0D, '', cterm0D, '', '', '')

	--- NERDTree highlighting
	hi('NERDTreeDirSlash', gui0D, '', cterm0D, '', '', '')
	hi('NERDTreeExecFile', gui05, '', cterm05, '', '', '')

	--- PHP highlighting
	hi('phpMemberSelector', gui05, '', cterm05, '', '', '')
	hi('phpComparison', gui05, '', cterm05, '', '', '')
	hi('phpParent', gui05, '', cterm05, '', '', '')
	hi('phpMethodsVar', gui0C, '', cterm0C, '', '', '')

	--- Python highlighting
	hi('pythonOperator', gui0E, '', cterm0E, '', '', '')
	hi('pythonRepeat', gui0E, '', cterm0E, '', '', '')
	hi('pythonInclude', gui0E, '', cterm0E, '', '', '')
	hi('pythonStatement', gui0E, '', cterm0E, '', '', '')

	--- Ruby highlighting
	hi('rubyAttribute', gui0D, '', cterm0D, '', '', '')
	hi('rubyConstant', gui0A, '', cterm0A, '', '', '')
	hi('rubyInterpolationDelimiter', gui0F, '', cterm0F, '', '', '')
	hi('rubyRegexp', gui0C, '', cterm0C, '', '', '')
	hi('rubySymbol', gui0B, '', cterm0B, '', '', '')
	hi('rubyStringDelimiter', gui0B, '', cterm0B, '', '', '')

	--- SASS highlighting
	hi('sassidChar', gui08, '', cterm08, '', '', '')
	hi('sassClassChar', gui09, '', cterm09, '', '', '')
	hi('sassInclude', gui0E, '', cterm0E, '', '', '')
	hi('sassMixing', gui0E, '', cterm0E, '', '', '')
	hi('sassMixinName', gui0D, '', cterm0D, '', '', '')

	--- Signify highlighting
	hi('SignifySignAdd', gui0B, gui01, cterm0B, cterm01, '', '')
	hi('SignifySignChange', gui0D, gui01, cterm0D, cterm01, '', '')
	hi('SignifySignDelocale', gui08, gui01, cterm08, cterm01, '', '')

	--- Spelling highlighting
	hi('SpellBad', '', '', '', '', 'undercurl', gui08)
	hi('SpellLocal', '', '', '', '', 'undercurl', gui0C)
	hi('SpellCap', '', '', '', '', 'undercurl', gui0D)
	hi('SpellRare', '', '', '', '', 'undercurl', gui0E)

	--- Startify highlighting
	hi('StartifyBracket', gui03, '', cterm03, '', '', '')
	hi('StartifyFile', gui07, '', cterm07, '', '', '')
	hi('StartifyFooter', gui03, '', cterm03, '', '', '')
	hi('StartifyHeader', gui0B, '', cterm0B, '', '', '')
	hi('StartifyNumber', gui09, '', cterm09, '', '', '')
	hi('StartifyPath', gui03, '', cterm03, '', '', '')
	hi('StartifySection', gui0E, '', cterm0E, '', '', '')
	hi('StartifySelect', gui0C, '', cterm0C, '', '', '')
	hi('StartifySlash', gui03, '', cterm03, '', '', '')
	hi('StartifySpecial', gui03, '', cterm03, '', '', '')

	--- Java highlighting
	hi('javaOperator', gui0D, '', cterm0D, '', '', '')

	--- Treesitter highlighting
	hi('TSFunction', gui0D, '', cterm0D, '', '', '')
	hi('TSKeywordFunction', gui0E, '', cterm0E, '', '', '')
	hi('TSMethod', gui0D, '', cterm0D, '', '', '')
	hi('TSProperty', gui0A, '', cterm0A, '', '', '')
	hi('TSPunctBracket', gui0C, '', cterm0C, '', '', '')
	hi('TSType', gui08, '', cterm08, '', 'none', '')
	hi('TSDefinition', '', gui03, '', cterm03, '', '')
	hi('TSDefinitionUsage', '', gui02, '', cterm02, 'none', '')

	--- LSP highlighting
	hi('LspDiagnosticsDefaultError', gui08, '', cterm08, '', '', '')
	hi('LspDiagnosticsDefaultWarning', gui09, '', cterm09, '', '', '')
	hi('LspDiagnosticsDefaultInformation', gui05, '', cterm05, '', '', '')
	hi('LspDiagnosticsDefaultHint', gui03, '', cterm03, '', '', '')

	hi('LspDiagnosticsSignError', gui08, gui01, cterm08, '', '', '')
	hi('LspDiagnosticsSignWarning', gui09, gui01, cterm09, '', '', '')
	hi('LspDiagnosticsSignInformation', gui05, gui01, cterm05, '', '', '')
	hi('LspDiagnosticsSignHint', gui03, gui01, cterm03, '', '', '')
end

return colorscheme
