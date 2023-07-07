
-- automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'folke/tokyonight.nvim'

  use{
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
     'nvim-tree/nvim-web-devicons', -- optional
	  }
	}

  use 'lewis6991/gitsigns.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    "williamboman/mason.nvim",
    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
  }

  use 'mfussenegger/nvim-jdtls'

	use 'neovim/nvim-lspconfig'

	use {
		"hrsh7th/nvim-cmp",
		requires = {
			'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
			'hrsh7th/cmp-vsnip',
			'hrsh7th/vim-vsnip',
			'onsails/lspkind.nvim',
	  }
	}

end)

