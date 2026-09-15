return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
    -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  	opts = {
      ensure_installed = {
        "c", "rust", "cpp", "lua", "python", "toml", "nix", "perl", "ruby",
        "html", "css", "bash", "devicetree", "vim", "vimdoc", "bitbake"
      },
  	},
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  },

  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
  },

  {
    "axelf4/vim-strip-trailing-whitespace",
    lazy = false,
    cmd = { "StripTrailingWhitespace" },
  },

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require "configs.dap-config"
    end,
  },
}
