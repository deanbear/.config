-- nvim-tree configs
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
		  quit_on_open = true,
	  }
  }
})
-- colorscheme
vim.cmd[[colorscheme tokyonight]]
-- gitsigns
if pcall(require, "gitsigns") then
  require('gitsigns').setup()
end
-- mason
if pcall(require, "mason") then
	require('mason').setup()
end
-- nvim-cmp
local cmp = require 'cmp'
local lspkind = require('lspkind')
cmp.setup {
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'vsnip' },
	},
	snippet = {
		expand = function(args)
			-- Comes from vsnip
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-k>'] = cmp.mapping.scroll_docs(-4),
		['<C-j>'] = cmp.mapping.scroll_docs(4),
		['<M-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol_text', -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
		})
	}
}
-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	matchup = {
		enable = true,
	},
}
-- telescope
require('telescope').setup({
	defaults = {
		path_display = {
			shorten = {
				len = 3, exclude = {1, -1}
			},
			truncate = true
		},
		dynamic_preview_title = true,
	},
})
