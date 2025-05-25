return {
	{
		"Olical/conjure",
		ft = { "clojure","scm" }, -- etc
		lazy = true,
		init = function()
			-- Set configuration options here
			-- Uncomment this to get verbose logging to help diagnose internal Conjure issues
			-- This is VERY helpful when reporting an issue with the project
			-- vim.g["conjure#debug"] = true
		end,

		-- Optional cmp-conjure integration
		dependencies = { "PaterJason/cmp-conjure" },
	},
	{
		"PaterJason/cmp-conjure",
		lazy = true,
		config = function()
			local cmp = require("cmp")
			local config = cmp.get_config()
			table.insert(config.sources, { name = "conjure" })
			return cmp.setup(config)
		end,
	},
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "storm",
				-- on_colors = function(colors)
				--   colors.comment = "#999999"
				-- end,
				on_highlights = function(hl)
					hl.DiagnosticUnnecessary = {
						fg = "#999999",
					}
					hl.LspInlayHint = {
						fg = "#9DA9A0",
					}
				end,
			})

			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight-storm]])
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"onsails/lspkind.nvim",
		},
	},
	"mfussenegger/nvim-jdtls",
	"neovim/nvim-lspconfig",
	"deanbear/null-ls.nvim",
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({})
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	-- {
	--   "keaising/im-select.nvim",
	--   config = function()
	--     require("im_select").setup()
	--   end,
	-- },
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"famiu/bufdelete.nvim",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},
}
