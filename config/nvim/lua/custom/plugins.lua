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
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      ensure_installed = {"c", "rust", "cpp", "lua", "python", "toml", "nix", "perl", "ruby", "html", "css", "bash", "devicetree"},
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      require "plugins.configs.nvimtree"
      require "custom.configs.nvimtree"
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
  },

  {
    "Deedone/checkpatch.nvim",
    cmd = { "CheckpatchEnable", "CheckpatchDisable"},
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
    cmd = "Gen",
    opts = {
      model = "codellama:7b",
      display_mode = "split",
    },
  },

}

return plugins
