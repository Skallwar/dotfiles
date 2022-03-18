-- Bootstrap
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.api.nvim_command 'packadd packer.nvim'
end

-- Auto compile packer plugin
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

return require('packer').startup(function()
  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- Code
  use 'neovim/nvim-lspconfig'
  -- use 'hrsh7th/nvim-cmp'
  use 'ray-x/lsp_signature.nvim'
  use 'github/copilot.vim'
  use 'sheerun/vim-polyglot'
  use 'p00f/nvim-ts-rainbow'
  use 'miyakogi/conoline.vim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Tools
  use 'norcalli/nvim_utils'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'vim-airline/vim-airline'
  use 'junegunn/fzf.vim'
  use 'junegunn/fzf'
  use 'farmergreg/vim-lastplace'

  -- Colorscheme
  use 'EdenEast/nightfox.nvim'
  use 'jacoborus/tender.vim'
  use 'sainnhe/edge'
end)
