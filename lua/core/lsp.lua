vim.lsp.enable 'basedpyright'
vim.lsp.enable 'lua_ls'
vim.lsp.enable 'ruff'
vim.lsp.enable 'rust_analyzer'
vim.lsp.enable 'clangd'
vim.lsp.enable 'cmake'

-- TODO enable diagnostics
vim.diagnostic.config {
  virtual_lines = {
    current_line = true,
  },
}
