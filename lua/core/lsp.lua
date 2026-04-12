vim.lsp.enable("lua_ls")
vim.lsp.enable("basedpyright")
vim.lsp.enable("ruff")
vim.lsp.enable("stylua")
-- vim.lsp.enable("clangd")
-- vim.lsp.enable("cmake")

-- TODO enable diagnostics
vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
  },
})
