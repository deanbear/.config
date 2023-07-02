
-- visual mode move up / down a line
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })

-- visual mode indentation & keep cursor position
vim.api.nvim_set_keymap('x', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('x', '>', '>gv', { noremap = true })

-- paste
vim.api.nvim_set_keymap('n', 'P', '"+]p', { noremap = true })
vim.api.nvim_set_keymap('x', 'p', '"_dp', { noremap = true })
-- copy
vim.api.nvim_set_keymap('n', 'Y', '"+y$', { noremap = true })
vim.api.nvim_set_keymap('x', 'Y', '"+y', { noremap = true })

-- nohls
vim.api.nvim_set_keymap('n', '<CR>', ':nohlsearch<CR>', {noremap = true})

-- NvimTree
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', {noremap = true})


