require("nvchad.configs.lspconfig").defaults()

local servers = { "clangd", "rust_analyzer", "lua_ls", "nil_ls", "pylyzer", "ruff", "bitbake-language-server" }
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
local cmds = {
  clangd = { "clangd", "--clang-tidy", "--offset-encoding=utf-16" },
}

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = settings[serve],
    cmd = cmds[server],
  })

  vim.lsp.enable(server)
end

