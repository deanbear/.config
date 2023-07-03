-- nvim-tree configs

-- disable netrw at the very start of your init.lua
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
-- empty setup using defaults
require("nvim-tree").setup()

-- colorscheme
vim.cmd[[colorscheme tokyonight]]

-- gitsigns
if pcall(require, "gitsigns") then
  require('gitsigns').setup()
end

