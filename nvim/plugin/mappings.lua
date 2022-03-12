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
