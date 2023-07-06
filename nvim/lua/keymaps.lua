
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

--tab management
vim.api.nvim_set_keymap('n', 'tn', ':tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tw', ':tabclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'th', ':tabprev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tl', ':tabnext<CR>', { noremap = true })
-- nohls
vim.api.nvim_set_keymap('n', '<Leader><CR>', ':nohlsearch<CR>', {noremap = true})

-- NvimTree
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', {noremap = true})

-- telescope
if pcall(require, "telescope.builtin") then
local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  vim.keymap.set('n', '<leader>fc', builtin.command_history, {})
	vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
  vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
  vim.keymap.set('n', '<leader>fi', builtin.lsp_incoming_calls, {})
  vim.keymap.set('n', '<leader>fo', builtin.lsp_outgoing_calls, {})
  vim.keymap.set('n', '<leader>fm', builtin.lsp_implementations, {})
end
