local autocomplete = {}

local expansion_active = false

function autocomplete.setup_mappings()
	vim.api.nvim_buf_set_keymap(0, 'i',
	vim.api.nvim_get_var('UltiSnipsJumpForwardTrigger'),
	[[<C-R>=luaeval("require('config.autocomplete').expand_or_jump('n')")<CR>]],
	{ noremap = true, silent = true })

	vim.api.nvim_buf_set_keymap(0, 's',
	vim.api.nvim_get_var('UltiSnipsJumpForwardTrigger'),
	[[<Esc><cmd>lua require('config.autocomplete').expand_or_jump('n')<CR>]],
	{ noremap = true, silent = true })

	vim.api.nvim_buf_set_keymap(0, 'i',
	vim.api.nvim_get_var('UltiSnipsJumpBackwardTrigger'),
	[[<C-R>=luaeval("require('config.autocomplete').expand_or_jump('p')")<CR>]],
	{ noremap = true, silent = true })

	vim.api.nvim_buf_set_keymap(0, 's',
	vim.api.nvim_get_var('UltiSnipsJumpBackwardTrigger'),
	[[<Esc><cmd>lua require('config.autocomplete').expand_or_jump('p')<CR>]],
	{ noremap = true, silent = true })

	vim.api.nvim_buf_set_keymap(0, 'i', '<CR>',
	[[pumvisible() ? '<C-Y>' : '<CR>']],
	{ noremap = true, expr = true, silent = true })

	vim.api.nvim_buf_set_keymap(0, 's', '<CR>',
	[[pumvisible() ? '<C-Y>' : '<CR>']],
	{ noremap = true, expr = true, silent = true })

	expansion_active = true
end

function autocomplete.teardown_mappings()
	vim.api.nvim_buf_set_keymap(0, 'i', '<CR>', '<CR>',
	{ noremap = true, silent = true })

	vim.api.nvim_buf_set_keymap(0, 's', '<CR>', '<CR>',
	{ noremap = true, silent = true })

	expansion_active = false
end

local function get_tabspace()
	if vim.api.nvim_get_option('softtabstop') <= 0 then
		if vim.fn.exists('*shiftwidth') == 1 then
			return vim.fn.shiftwidth()
		else
			if vim.api.nvim_get_option('shiftwidth') == 0 then
				return vim.api.nvim_get_option('tabstop')
			else
				return vim.api.nvim_get_option('shiftwidth')
			end
		end
	else
		return vim.api.nvim_get_option('softtabstop')
	end
end

local function smart_tab()
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
			local current_column = vim.fn.virtcol({ vim.fn.line('.'), previous_column }) + 1
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

vim.api.nvim_set_var('ulti_jump_backwards_res', 0)
vim.api.nvim_set_var('ulti_jump_forwards_res', 0)
vim.api.nvim_set_var('ulti_expand_res', 0)

function autocomplete.expand_or_jump(direction)
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

vim.api.nvim_set_var('UltiSnipsJumpForwardTrigger', '<Tab>')
vim.api.nvim_set_var('UltiSnipsJumpBackwardTrigger', '<S-Tab>')

vim.api.nvim_set_var('UltiSnipsMappingsToIgnore', {'autocomplete'})
vim.api.nvim_set_var('UltiSnipsSnippetDirectories', {'ultisnips'})

vim.api.nvim_set_keymap('i', '<C-j>', "pumvisible() ? '<C-n>' : '<C-j>'",
{ noremap = true, expr = true })

vim.api.nvim_set_keymap('i', '<C-k>', "pumvisible() ? '<C-p>' : '<C-k>'",
{ noremap = true, expr = true })

vim.api.nvim_buf_set_var(0, 'did_after_plugin_ultisnips_after', 1)

if vim.fn.exists(':UltiSnipsEdit') == 2 then
	vim.api.nvim_set_keymap('i',
	vim.api.nvim_get_var('UltiSnipsExpandTrigger'),
	[[<C-R>=luaeval("require('config.autocomplete').expand_or_jump('n')")<CR>]],
	{ noremap = true, silent = true })

	vim.api.nvim_set_keymap('s',
	vim.api.nvim_get_var('UltiSnipsExpandTrigger'),
	[[<Esc><cmd>lua require('config.autocomplete').expand_or_jump('n')<CR>]],
	{ noremap = true, silent = true })

	vim.api.nvim_set_keymap('i',
	vim.api.nvim_get_var('UltiSnipsJumpBackwardTrigger'),
	[[<C-R>=luaeval("require('config.autocomplete').expand_or_jump('p')")<CR>]],
	{ noremap = true, silent = true })

	vim.api.nvim_set_keymap('s',
	vim.api.nvim_get_var('UltiSnipsJumpBackwardTrigger'),
	[[<Esc><cmd>lua require('config.autocomplete').expand_or_jump('p')<CR>]],
	{ noremap = true, silent = true })
end

require('compe').setup {
	enabled = true;
	autocomplete = true;
	debug = true;
	min_length = 1;
	preselect = 'enable';
	throttle_time = 80;
	source_timeout = 200;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 100;
	documentation = true;

	source = {
		buffer = true;
		calc = true;
		nvim_lsp = true;
		path = true;
		ultisnips = true;
	};
}

return autocomplete
