return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        path_display = {
          shorten = {
            len = 3,
            exclude = { 1, -1 },
          },
          truncate = true,
        },
        dynamic_preview_title = true,
      },
    })
  end,
}
