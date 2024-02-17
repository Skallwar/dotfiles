local plugins = {
  {
    "neovim/nvim-lspconfig",
     config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
     end,

     dependencies = {
       "jose-elias-alvarez/null-ls.nvim",
       config = function()
       require "custom.configs.null-ls"
     end,
   },

  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {"c", "rust", "cpp", "lua", "python", "toml", "nix", "perl", "ruby", "html", "css", "bash", "devicetree"},
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      require "plugins.configs.nvimtree"
      require "custom.configs.nvimtree"
    end,
  },

  { "tpope/vim-fugitive", lazy = false },
  { 
    "Deedone/checkpatch.nvim", lazy = false,
    config = function()
      require "custom.configs.checkpatch"
    end
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   config = function()
  --     require "custom.configs.checkpatch"
  --   end,
  -- },

  -- LLM stuff
  {
    "David-Kunz/gen.nvim",
    lazy = false,
    opts = {
      model = "codellama:7b",
      display_mode = "split",
    },
  },

}

return plugins
