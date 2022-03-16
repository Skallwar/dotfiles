require('plugins')
require('lsp')

vim.opt.number = true
vim.opt.colorcolumn = '80'
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wildmenu = true
vim.cmd([[
   set path+=$PWD/**
]])
-- vim.opt.listchars = { trail = '.', tab = '>' }
-- Fixme this is ugly
vim.cmd([[
   set listchars=trail:.,tab:>\ ,
]])

---- Color and syntax
vim.cmd([[
   let g:edge_transparent_background = 1
   set termguicolors
   colorscheme edge
   highlight ColorColumn ctermbg=darkgrey
]])
-- Treesitter
require'nvim-treesitter.configs'.setup {
   highlight = {
      enable = true
   },

   ensure_installed = {
      "c",
      "rust",
      "go",
      "lua",
      "toml",
      "python",
   },

   indent = {
      enable = false --true
   },

   additional_vim_regex_highlighting = false,

   rainbow = {
      enable = true,
      extended_mode = false, -- Also highlight non-bracket delimiters
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
   }
}
-- Polyglot
vim.g["polyglot_disabled"] = { "ada" }
----

---- Keybindings
-- Fzf
vim.api.nvim_set_keymap('n', 'f', ':Files<CR>', { noremap = true, silent = true })
----

---- Copilot
vim.g["copilot_enabled"] = false

