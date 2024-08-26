local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities
-- capabilities.offsetEncoding = "utf-8"

local lspconfig = require "lspconfig"
local servers = { "clangd", "rust_analyzer", "lua_ls", "nil_ls", "pylyzer", "ruff_lsp" }
local mason_servers = { "clangd", "rust-analyzer", "lua-language-server", "nil", "pylyzer", "ruff-lsp" }
local settings = {
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}

lspconfig.clangd.cmd = { "clangd", "--clang-tidy", "--offset-encoding=utf-16" }

-- lspconfig.lua_ls.settings.Lua.diagnostics.globals = { "vim" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = settings[lsp],
  }
end

return mason_servers
