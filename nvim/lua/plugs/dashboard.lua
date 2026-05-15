return {
  "glepnir/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "hyper",
      config = {
        week_header = {
          enable = false,
        },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = " Grep",
            group = "Number",
            action = "Telescope live_grep",
            key = "g",
          },
          {
            desc = " Config",
            action = "tabnew $MYVIMRC | tcd %:p:h",
            key = "c",
          },
        },
        header = {

          "██████╗  █████╗ ██╗     ███████╗    ██████╗ ██╗     ██╗   ██╗███████╗    ██████╗  ██████╗ ████████╗",
          "██╔══██╗██╔══██╗██║     ██╔════╝    ██╔══██╗██║     ██║   ██║██╔════╝    ██╔══██╗██╔═══██╗╚══██╔══╝",
          "██████╔╝███████║██║     █████╗      ██████╔╝██║     ██║   ██║█████╗      ██║  ██║██║   ██║   ██║   ",
          "██╔═══╝ ██╔══██║██║     ██╔══╝      ██╔══██╗██║     ██║   ██║██╔══╝      ██║  ██║██║   ██║   ██║   ",
          "██║     ██║  ██║███████╗███████╗    ██████╔╝███████╗╚██████╔╝███████╗    ██████╔╝╚██████╔╝   ██║   ",
          "╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝    ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝    ╚═════╝  ╚═════╝    ╚═╝   ",
          "                                                                                                   ",
        },
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
