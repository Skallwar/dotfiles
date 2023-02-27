require('nvim_utils')

-- UI
vim.cmd [[
   augroup lsp
      autocmd!
      autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float({focusable=false})
   augroup end
]]

require "lsp_signature".setup({
   bind = true,
   hint_prefix = "",
   handler_opts = {
      border = "none"
   },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
   vim.lsp.diagnostic.on_publish_diagnostics, {
   virtual_text = false,
   sign = true,
   update_in_insert = false,
}
)

-- Formating
-- FIXME: This should be removed once https://github.com/neovim/neovim/pull/14661
local autocmds = {
   todo = {
      { "BufWritePre", "*.rs", "lua", "vim.lsp.buf.formatting_sync(nil, 1000)" };
      { "BufWritePre", "*.{c,cc,cpp,h,hh,hpp}", "lua", "vim.lsp.buf.formatting_sync(nil, 1000)" };
      { "BufWritePre", "*.go", "lua", "vim.lsp.buf.formatting_sync(nil, 1000)" };
      { "BufWritePre", "*.lua", "lua", "vim.lsp.buf.formatting_sync(nil, 1000)" };
   };
}
nvim_create_augroups(autocmds)

-- Keybinds
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lsp_attach = function(client, bufnr)
   print("LSP started");
   -- Enable completion triggered by <c-x><c-o>
   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

   -- Mappings.
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Language server
require 'lspconfig'.clangd.setup {}

require 'lspconfig'.rust_analyzer.setup {
   on_attach = lsp_attach,
   settings = {
      ["rust-analyzer"] = {
         checkOnSave = {
            extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" },
            command = "clippy"
         }
      }
   }
}
require 'lspconfig'.gopls.setup {}
require 'lspconfig'.als.setup {}
require 'lspconfig'.racket_langserver.setup {}
require 'lspconfig'.lua_ls.setup {
   on_attach = lsp_attach,

   cmd = { "/bin/env", "lua-language-server" },

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
