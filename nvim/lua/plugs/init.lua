-- Automatically install lazy.nvim if it does not exist
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("plugs.comm-cfgs"),
  require("plugs.nvim-tree"),
  require("plugs.telescope"),
  require("plugs.flash"),
  require("plugs.treesitter"),
  require("plugs.bufferline"),
  require("plugs.symbols-outline"),
})
