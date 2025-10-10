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
        "html", "css", "bash", "devicetree", "vim", "vimdoc"
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
}
