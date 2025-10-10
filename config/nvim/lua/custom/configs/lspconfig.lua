local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities
-- capabilities.offsetEncoding = "utf-8"

local servers = { "clangd", "rust_analyzer", "lua_ls", "nil_ls", "pylyzer", "ruff" }
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

vim.lsp.config('clangd', {
  cmd = { "clangd", "--clang-tidy", "--offset-encoding=utf-16" },
  on_attach = on_attach,
  capabilities = capabilities,
})

for _, lsp in ipairs(servers) do
  if lsp ~= "clangd" then -- clangd already configured above
    vim.lsp.config(lsp, {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = settings[lsp],
    })
  end

  vim.lsp.enable(lsp)
end

return mason_servers
