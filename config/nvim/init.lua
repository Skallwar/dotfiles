require('plugins')
require('lsp')

vim.opt.number = true
vim.opt.colorcolumn = '80'
vim.cmd([[
   highlight ColorColumn ctermbg=darkgrey
]])
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.listchars = { trail = '.', tab = '>' }
-- Fixme this is ugly
vim.cmd([[
   set listchars=trail:.,tab:>\ ,
]])

---- Color and syntax
vim.cmd('colorscheme edge')
vim.g["edge_style"] = 'black'
vim.t_Co = 256
vim.base16colorspace=256
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

