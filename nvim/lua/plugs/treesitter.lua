-- return {
--   "nvim-treesitter/nvim-treesitter",
-- 	branch = 'master',
--   build = ":TSUpdate",
--   config = function()
--     local configs = require("nvim-treesitter.configs")
--
--     configs.setup({
--       highlight = {
--         enable = true,
--
--         -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--         -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--         -- Using this option may slow down your editor, and you may see some duplicate highlights.
--         -- Instead of true it can also be a list of languages
--         additional_vim_regex_highlighting = false,
--       },
--       matchup = {
--         enable = true,
--       },
--     })
--   end,
-- }

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup({})
  end,
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
