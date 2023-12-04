-- visual mode move up / down a line
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })

-- visual mode indentation & keep cursor position
vim.keymap.set("x", "<", "<gv", { noremap = true })
vim.keymap.set("x", ">", ">gv", { noremap = true })

-- paste
vim.keymap.set("n", "P", '"+]p', { noremap = true })
vim.keymap.set("x", "p", '"_dp', { noremap = true })
-- copy
vim.keymap.set("n", "Y", '"+y$', { noremap = true })
vim.keymap.set("x", "Y", '"+y', { noremap = true })

--buf management
vim.keymap.set("n", "<Leader>bn", ":bn<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>bd", ":bd<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>bp", ":bp<CR>", { noremap = true })
--bufferline
vim.keymap.set("n", "<Leader>pb", ":BufferLinePick<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>cb", ":BufferLinePickClose<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>ob", ":%bd|e#|bd#<CR>:NvimTreeFindFileToggle!<CR>", { noremap = true })

-- nohls
vim.keymap.set("n", "<Leader><CR>", ":nohlsearch<CR>", { noremap = true })

--quickfix
vim.keymap.set("n", "<Leader>qf", require("qkfx").toggle, { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>ql", require("qkfx").load, { silent = true, noremap = true })

-- NvimTree
vim.keymap.set("n", "<Leader>tr", ":NvimTreeFindFileToggle!<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>tt", ":NvimTreeFocus<CR>", { noremap = true })

-- telescope
if pcall(require, "telescope.builtin") then
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
  vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
  vim.keymap.set("n", "<leader>fc", builtin.command_history, {})
  vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
  vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
  vim.keymap.set("n", "<leader>fi", builtin.lsp_incoming_calls, {})
  vim.keymap.set("n", "<leader>fo", builtin.lsp_outgoing_calls, {})
  vim.keymap.set("n", "<leader>fm", builtin.lsp_implementations, {})
  vim.keymap.set("n", "<leader>fd", builtin.lsp_dynamic_workspace_symbols, {})
  vim.keymap.set("n", "<leader>fx", builtin.diagnostics, {})
end
