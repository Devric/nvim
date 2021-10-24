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
  use 'kana/vim-smartinput' -- auto close delimiters
  use 'tpope/vim-commentary'
  -- gcc, gcu, gcap

  -- http://neovimcraft.com/plugin/ms-jpq/coq_nvim/index.html
  -- https://github.com/tpope/vim-dadbod
  -- https://github.com/tpope/vim-dispatch
  -- https://dev.to/voyeg3r/my-ever-growing-neovim-init-lua-h0p

  -- =======================
  -- End edit Plugin> run PackerSync after adding plugin
  -- =======================

  -- if packer_bootstrap then
	-- require('packer').sync()
  -- end
end)
