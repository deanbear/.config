vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.scrolloff = 14
vim.g.noswapfile = true
vim.opt.shortmess:append("S")

vim.cmd([[
function! MyQuickfixtext(opts)
	return luaeval('require("qkfx").quickfixtext(_A)', a:opts)
endfunction
set quickfixtextfunc=MyQuickfixtext
]])
