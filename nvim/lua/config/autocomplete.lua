local autocomplete = {}

local expansion_active = false

autocomplete.setup_mappings = function()
	local opts = { noremap = true, silent = true, }

	vim.api.nvim_buf_set_keymap(0, 'i',
	vim.api.nvim_get_var('UltiSnipsJumpForwardTrigger'),
	"<C-R>=luaeval(\"require'config.autocomplete'.expand_or_jump('n')\")<CR>", opts)

	vim.api.nvim_buf_set_keymap(0, 's',
	vim.api.nvim_get_var('UltiSnipsJumpForwardTrigger'),
	"<Esc>:lua require'config.autocomplete'.expand_or_jump('n')<CR>", opts)

	vim.api.nvim_buf_set_keymap(0, 'i',
	vim.api.nvim_get_var('UltiSnipsJumpBackwardTrigger'),
	"<C-R>=luaeval(\"require'config.autocomplete'.expand_or_jump('p')\")<CR>", opts)

	vim.api.nvim_buf_set_keymap(0, 's',
	vim.api.nvim_get_var('UltiSnipsJumpBackwardTrigger'),
	"<Esc>:lua require'config.autocomplete'.expand_or_jump('p')<CR>", opts)

	local opts = { noremap = true, expr = true, silent = true }

	vim.api.nvim_buf_set_keymap(0, 'i', '<CR>', 'pumvisible() ? "<C-Y>" : "<CR>"', opts)
	vim.api.nvim_buf_set_keymap(0, 's', '<CR>', 'pumvisible() ? "<C-Y>" : "<CR>"', opts)

	expansion_active = true
end

autocomplete.teardown_mappings = function()
	local opts = { map = true, expr = true, silent = true }
	vim.api.nvim_buf_set_keymap(0, 'i', '<CR>', '', opts)
	vim.api.nvim_buf_set_keymap(0, 's', '<CR>', '', opts)

	expansion_active = false
end

vim.g.ulti_jump_backwards_res = 0
vim.g.ulti_jump_forwards_res = 0
vim.g.ulti_expand_res = 0

autocomplete.expand_or_jump = function(direction)
	vim.cmd('call UltiSnips#ExpandSnippet()')
	if vim.api.nvim_get_var('ulti_expand_res') == 0 then
		if vim.fn.pumvisible() == 1 then
			if direction == 'n' then
				return vim.api.nvim_replace_termcodes('<C-n>', true, false, true)
			else
				return vim.api.nvim_replace_termcodes('<C-p>', true, false, true)
			end
		else
			if expansion_active then
				if direction == 'n' then
					vim.cmd('call UltiSnips#JumpForwards()')
					if vim.api.nvim_get_var('ulti_jump_forwards_res') == 0 then
						return vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
					end
				else
					vim.cmd('call UltiSnips#JumpBackwards()')
				end
			else
				if direction == 'n' then
					return smart_tab()
				end
			end
		end
	end

	return ''
end

if vim.fn.exists('*shiftwidth') then
	get_tabspace = function()
		if vim.api.nvim_get_option('softtabstop') <= 0 then
			return vim.fn.shiftwidth()
		else
			return vim.api.nvim_get_option('softtabstop')
		end
	end
else
	get_tabspace = function()
		if vim.api.nvim_get_option('softtabstop') <= 0 then
			if vim.api.nvim_get_option('shiftwidth') == 0 then
				return vim.api.nvim_get_option('tabstop')
			else
				return vim.api.nvim_get_option('shiftwidth')
			end
		else
			return vim.api.nvim_get_option('softtabstop')
		end
	end
end

smart_tab = function()
	if vim.fn.exists('l:expandtab') ~= 0 then
		return vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
	else
		local prefix = vim.fn.strpart(vim.fn.getline('.'), 0, vim.fn.col('.') -1)
		if prefix == '' then
			return vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
		else
			local sw = get_tabspace()
			local previous_char = vim.fn.matchstr(prefix, '.$')
			local previous_column = vim.fn.strlen(prefix) - vim.fn.strlen(previous_char) + 1
			local current_column = vim.fn.virtcol("[vim.fn.line('.'), previous_column]") + 1
			local remainder = (current_column - 1) % sw
			local move
			if remainder == 0 then
				move = sw
			else
				move = sw - remainder
			end
			return vim.api.nvim_call_function('repeat', { ' ', move })
		end
	end
end

autocomplete.deoplete_init = function()
	local deoplete_init_done
	if deoplete_init_done then
		return
	end
	deoplete_init_done = true

	vim.cmd('call deoplete#enable()')
	vim.cmd("call deoplete#custom#source('file', 'rank', 2000)")
	vim.cmd("call deoplete#custom#source('ultisnips', 'rank', 1000)")
	vim.cmd("call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])")
end

vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'

vim.g.UltiSnipsMappingsToIgnore = {"autocomplete"}
vim.g.UltiSnipsSnippetDirectories = {"ultisnips"}

local opts = { noremap = true, expr = true }
vim.api.nvim_set_keymap('i', '<C-j>', "pumvisible() ? '<C-n>' : '<C-j>'", opts)
vim.api.nvim_set_keymap('i', '<C-k>', "pumvisible() ? '<C-p>' : '<C-k>'", opts)

vim.b.did_after_plugin_ultisnips_after = 1

if vim.fn.exists(':UltiSnipsEdit') then
	local opts = { noremap = true, silent = true }

	vim.api.nvim_set_keymap('i',
	vim.api.nvim_get_var('UltiSnipsExpandTrigger'),
	"<C-R>=luaeval(\"require'config.autocomplete'.expand_or_jump('n')\")<CR>", opts)

	vim.api.nvim_set_keymap('s',
	vim.api.nvim_get_var('UltiSnipsExpandTrigger'),
	"<Esc>:lua require'config.autocomplete'.expand_or_jump('n')<CR>", opts)

	vim.api.nvim_set_keymap('i',
	vim.api.nvim_get_var('UltiSnipsJumpBackwardTrigger'),
	"<C-R>=luaeval(\"require'config.autocomplete'.expand_or_jump('p')\")<CR>", opts)

	vim.api.nvim_set_keymap('s',
	vim.api.nvim_get_var('UltiSnipsJumpBackwardTrigger'),
	"<Esc>:lua require'config.autocomplete'.expand_or_jump('p')<CR>", opts)
end

return autocomplete
