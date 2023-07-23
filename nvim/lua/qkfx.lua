local api = vim.api
local M = {}
local win_pre_copen = nil

function M.toggle()
  for _, win in pairs(api.nvim_list_wins()) do
    local buf = api.nvim_win_get_buf(win)
    if api.nvim_buf_get_option(buf, "buftype") == "quickfix" then
      api.nvim_command("cclose")
      if win_pre_copen then
        local ok, w = pcall(api.nvim_win_get_number, win_pre_copen)
        if ok and api.nvim_win_is_valid(w) then
          api.nvim_set_current_win(w)
        end
        win_pre_copen = nil
      end
      return
    end
  end

  -- no quickfix buffer found so far, so show it
  win_pre_copen = api.nvim_get_current_win()
  api.nvim_command("belowright copen")
end

local efms = {
  python = [[%C %.%#,%A  File "%f"\, line %l%.%#,%Z%[%^ ]%\@=%m]],
}

function M.load()
  local buf = api.nvim_get_current_buf()
  local ft = vim.b[buf]["dap-type"] or vim.bo.filetype
  local efm = efms[ft] or vim.bo[buf].errorformat or vim.g.errorformat
  local lines = api.nvim_buf_get_lines(buf, 0, -1, true)
  if efm and #efm ~= 0 then
    vim.fn.setqflist({}, "r", { efm = efm, lines = lines })
  end
  vim.cmd("belowright copen")
end

function M.format_uri(uri)
  if vim.startswith(uri, "jdt://") then
    local artifact = uri:match("contents/([%a%d._-]+).jar") or ""
    local package = uri:match("contents/[%a%d._-]+/([%a%d._-]+)") or ""
    local class = uri:match("contents/[%a%d._-]+/[%a%d._-]+/([%a%d$]+).class") or ""
    return string.format("%s::%s::%s", artifact, package, class)
  else
    local fname = vim.fn.fnamemodify(vim.uri_to_fname(uri), ":.")
    fname = fname:gsub("src/main/java/", "s/m/j/")
    fname = fname:gsub("src/test/java/", "s/t/j/")
    return fname
  end
end

-- quickfixtextfunc to be used with nvim-jdtls:
-- Turns entries like `jdt://contents/java.xml/[...]/ListDatatypeValidator.class` into `package.name::ClassName: [Class] ListDatatypeValidator`
function M.quickfixtext(opts)
  if opts.quickfix == 0 then
    return nil
  end
  local qflist = vim.fn.getqflist({ id = opts.id, items = 0, title = 0, context = 0 })
  local ctx = qflist.context or {}
  if not ctx.client_id and qflist.title ~= "Language Server" and qflist.title ~= "LSP locations" then
    return nil
  end
  local result = {}
  for i, item in pairs(qflist.items) do
    if i >= opts.start_idx and i <= opts.end_idx then
      table.insert(
        result,
        string.format("%s|%d %d|%s", M.format_uri(vim.uri_from_bufnr(item.bufnr)), item.lnum, item.col, item.text)
      )
    end
  end
  return result
end

return M
