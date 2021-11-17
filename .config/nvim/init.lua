require('plugins')
require('nvim_utils')

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


---- Lsp config
-- Keybinds
local lsp_attach = function(client)
   print("LSP started");
   -- Use an on_attach function to only map the following keys
   -- after the language server attaches to the current buffer
   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

   -- Enable completion triggered by <c-x><c-o>
   -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

   -- Mappings.
   local opts = { noremap=true, silent=true }

   -- See `:help vim.lsp.*` for documentation on any of the below functions
   buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
   buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
   buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
   buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
   buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
   buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
   buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
   buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
   buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
   buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
   buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end
-- Language server
require'lspconfig'.clangd.setup{ on_attach=lsp_attach }
require'lspconfig'.rust_analyzer.setup{ on_attach=lsp_attach }
require'lspconfig'.gopls.setup{ on_attach=lsp_attach }
require'lspconfig'.als.setup{ on_attach=lsp_attach }
require'lspconfig'.sumneko_lua.setup{
   on_attach=lsp_attach,

   cmd = {"/bin/env", "lua-language-server"},

   settings = {
      Lua = {
         diagnostics = {
            globals = { 'vim', 'use' },
         },
         workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
         },
         telemetry = {
            enable = false,
         },
      },
   },
}
-- Formating
-- FIXME: This should be removed once https://github.com/neovim/neovim/pull/14661
local autocmds = {
   todo = {
      {"BufWritePre", "*.rs", "lua", "vim.lsp.buf.formatting_sync(nil, 1000)"};
      {"BufWritePre", "*.{c,cc,h,hh}", "lua", "vim.lsp.buf.formatting_sync(nil, 1000)"};
      {"BufWritePre", "*.go", "lua", "vim.lsp.buf.formatting_sync(nil, 1000)"};
      {"BufWritePre", "*.lua", "lua", "vim.lsp.buf.formatting_sync(nil, 1000)"};
   };
}
nvim_create_augroups(autocmds)
-- UI
vim.fn.sign_define('LspDiagnosticsSignError', { text = "✖", texthl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = "⚠", texthl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = "~" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false;
    update_in_insert = false,
  }
)

vim.cmd ([[
   autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})
   autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()
   highlight LspDiagnosticsDefaultError guifg=Red, ctermfg=Red
   highlight LspDiagnosticsDefaultHint guifg=#FFCC00 ctermfg=Yellow
   highlight LspDiagnosticsDefaultWarning guifg=#FFCC00 ctermfg=Yellow
   highlight NormalFloat ctermbg=234
]])
----

---- Keybindings
-- Fzf
vim.api.nvim_set_keymap('n', 'f', ':Files<CR>', { noremap = true, silent = true })
----

---- Copilot
vim.g["copilot_enabled"] = false
