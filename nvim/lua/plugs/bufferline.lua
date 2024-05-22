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

      --- name_formatter can be used to change the buffer's label in the bufferline.
      --- Please note some names can/will break the
      --- bufferline so use this at your discretion knowing that it has
      --- some limitations that will *NOT* be fixed.
      name_formatter = function(buf) -- buf contains:
        -- name                | str        | the basename of the active file
        -- path                | str        | the full path of the active file
        -- bufnr (buffer only) | int        | the number of the active buffer
        -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
        -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`:

        local buf_path = buf.path
        if vim.startswith(buf_path, "jdt://") then
          local class_name = buf_path:match("contents/[%a%d._-]+/[%a%d._-]+/([%a%d$]+.class)") or "jdt class"
          return class_name
        end
      end,
      custom_filter = function(
        buf_number,
        _ --[[ buf_numbers ]]
      )
        if vim.bo[buf_number].filetype == "qf" then
          return false
        elseif vim.startswith(vim.api.nvim_buf_get_name(buf_number), "gitsigns://") then
          return false
        end

        return true
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
