return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.2",
  dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
  config = function()
    local dropdown_opts = {
      theme = "dropdown",
      layout_config = {
        width = 0.7,
      },
    }
    require("telescope").setup({
      defaults = {
        path_display = {
          -- shorten = {
          --   len = 3,
          --   exclude = { 1, -1 },
          -- },
          truncate = true,
        },
        dynamic_preview_title = true,
      },
      pickers = {
        find_files = dropdown_opts,
        live_grep = dropdown_opts,
      },
    })
    -- To get fzf loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    require("telescope").load_extension("fzf")
  end,
}
