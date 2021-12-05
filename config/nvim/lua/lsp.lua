require('nvim_utils')

require "lsp_signature".setup({
      bind = true,
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

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--   vim.lsp.handlers.hover, { focusable = false }
-- )

-- Language server
require'lspconfig'.clangd.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.als.setup{}
require'lspconfig'.racket_langserver.setup{}
require'lspconfig'.sumneko_lua.setup{
   -- on_attach=lsp_attach,

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

      -- autocmd CursorHoldI,CursorMovedI * lua vim.lsp.buf.signature_help({focusable=false})
vim.cmd [[
   augroup lsp
      autocmd!
      autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})
   augroup end
]]

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

-- -- Keybinds
-- local lsp_attach = function(client)
--    print("LSP started");
--    -- Use an on_attach function to only map the following keys
--    -- after the language server attaches to the current buffer
--    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

--    -- Enable completion triggered by <c-x><c-o>
--    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

--    -- Mappings.
--    local opts = { noremap=true, silent=true }

--    -- See `:help vim.lsp.*` for documentation on any of the below functions
--    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- end



-- -- UI
-- vim.fn.sign_define('LspDiagnosticsSignError', { text = "✖", texthl = "LspDiagnosticsDefaultError" })
-- vim.fn.sign_define('LspDiagnosticsSignWarning', { text = "⚠", texthl = "LspDiagnosticsDefaultWarning" })
-- vim.fn.sign_define('LspDiagnosticsSignHint', { text = "~" })

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--   vim.lsp.handlers.hover, { focusable = false }
-- )

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = false;
--     update_in_insert = false,
--   }
-- )

-- vim.cmd ([[
--    highlight LspDiagnosticsDefaultError guifg=Red, ctermfg=Red
--    highlight LspDiagnosticsDefaultHint guifg=#FFCC00 ctermfg=Yellow
--    highlight LspDiagnosticsDefaultWarning guifg=#FFCC00 ctermfg=Yellow
--    highlight NormalFloat ctermbg=234
-- ]])


