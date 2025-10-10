local plugins = {
  {
    "neovim/nvim-lspconfig",
     config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
     end,

     dependencies = {
       "nvimtools/none-ls.nvim",
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
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = require "custom.configs.lspconfig",
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
}

return plugins
