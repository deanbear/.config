return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.opt.termguicolors = true
    require("nvim-tree").setup({

      disable_netrw = false,
      hijack_netrw = true,
      view = {
        adaptive_size = true,
        --float = {
        -- enable = true,
        --},
      },
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
    })
  end,
}
