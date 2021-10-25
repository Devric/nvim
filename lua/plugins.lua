-- Install packer
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
	use {'wbthomason/packer.nvim', opt = true}

	-- =======================
	-- Start edit Plugin
	-- =======================
	
	-- UI
	use 'morhetz/gruvbox' -- theme
	use 'olimorris/onedarkpro.nvim'
	use 'yamatsum/nvim-cursorline'
	use {
		'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config = function() require'lualine'.setup {
			theme = 'gruvbox'
		} end
	}
	use {
		'romgrk/barbar.nvim',
		requires = {'kyazdani42/nvim-web-devicons'}
	}
	use {
		'kyazdani42/nvim-tree.lua',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function() require'nvim-tree'.setup {} end
	}

	-- UTILITY
	use {
		"folke/which-key.nvim",
		config = function() require("which-key").setup {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		} end
	}
	use 'kana/vim-smartinput' -- auto close delimiters
	use 'tpope/vim-commentary'
	use {
		'phaazon/hop.nvim',
		as = 'hop',
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
		end
	}
	use {
		'karb94/neoscroll.nvim',
		config = function() require'neoscroll'.setup {} end
	}
	use "gregsexton/MatchTag"
	use "godlygeek/tabular"
	use { 'junegunn/fzf', run = './install --bin' }
	use {
		'ibhagwan/fzf-lua',
		requires = {
			'vijaymarupudi/nvim-fzf',
			'kyazdani42/nvim-web-devicons'
		}
	}
	use {
		"blackCauldron7/surround.nvim",
		config = function()
			require"surround".setup {mappings_style = "sandwich"}
		end
	}
	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			require('gitsigns').setup()
		end
	}
	use 'sindrets/diffview.nvim'
	use {
		'abecodes/tabout.nvim',
		config = function()
			require('tabout').setup { }
		end
	}
	
	-- allows quickly select window
	use 'https://gitlab.com/yorickpeterse/nvim-window.git'

	-- Syntax
	use 'windwp/nvim-ts-autotag' -- use with treesiter autotag enable
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require'nvim-treesitter.configs'.setup {
				autotag = {
					enable = true
				},
				hightlight = {
					enable = true
				},
				ensure_installed = {
					"jsonc",
					"dockerfile",
					"comment",
					"yaml",
					"toml",
					"lua",
					"graphql",
					"tsx",
					"css",
					"html",
					"svelte",
					"typescript",
					"javascript",
					"vue"
				}
			}
		end
	}

	-- LSP
	use {
		'neovim/nvim-lspconfig',
		'williamboman/nvim-lsp-installer',
	}
	use 'simrat39/symbols-outline.nvim'
	use 'glepnir/lspsaga.nvim'
	use {"ms-jpq/coq_nvim", branch = "coq"}
    use {"ms-jpq/coq.artifacts", branch = 'artifacts'}
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}



	-- http://neovimcraft.com/plugin/ms-jpq/coq_nvim/index.html
	-- https://github.com/tpope/vim-dadbod
	-- https://github.com/tpope/vim-dispatch
	-- https://dev.to/voyeg3r/my-ever-growing-neovim-init-lua-h0p

	-- =======================
	-- End edit Plugin> run PackerSync after adding plugin
	-- =======================

	if packer_bootstrap then
		require('packer').sync()
	end
end)

--vim.o.background = "dark"
--require 'onedarkpro' .load()
