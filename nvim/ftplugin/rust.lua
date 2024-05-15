vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  command = "w",
  buffer = 0,
  nested = true,
})
