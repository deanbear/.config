return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      -- diagnostics = "nvim_lsp",
      -- diagnostics_indicator = function(
      --   count,
      --   level,
      --   _, --[[ diagnostics_dict ]]
      --   _ --[[ context ]]
      -- )
      --   local icon = level:match("error") and " " or nil --" "
      --   return icon and icon .. count or ""
      -- end,
      close_command = "silent! bdelete %d",
      show_tab_indicators = false,

      custom_filter = function(
        buf_number,
        _ --[[ buf_numbers ]]
      )
        if vim.bo[buf_number].filetype ~= "qf" then
          return true
        end
        -- filter out filetypes you don't want to see
        -- if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        --   return true
        -- end
        -- filter out based on arbitrary rules
        -- e.g. filter out vim wiki buffer from tabline in your work repo
        -- if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        --   return true
        -- end
        -- filter out by it's index number in list (don't show first buffer)
        -- if buf_numbers[1] ~= buf_number then
        --   return true
        -- end
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = true,
        },
      },
    },
  },
}
