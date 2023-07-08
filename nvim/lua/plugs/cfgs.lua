return {
	{
		'folke/tokyonight.nvim',
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		'iamcco/markdown-preview.nvim',
		build = function() vim.fn['mkdp#util#install']() end,
	},
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
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
						quit_on_open = true,
					}
				}
			})
		end
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require("gitsigns").setup()
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').setup({
				defaults = {
					path_display = {
						shorten = {
							len = 3, exclude = { 1, -1 }
						},
						truncate = true
					},
					dynamic_preview_title = true,
				},
			})
		end
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup()
		end
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'hrsh7th/cmp-vsnip',
			'hrsh7th/vim-vsnip',
			'onsails/lspkind.nvim',
		},
		config = function()
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
		end,
	},
	'mfussenegger/nvim-jdtls',
	'neovim/nvim-lspconfig',
	'jose-elias-alvarez/null-ls.nvim',
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
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
			})
		end
	}
}
