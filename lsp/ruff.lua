---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  settings = {
    configurationPreference = "filesystemFirst",
    lineLength = 100,
    lint = {
      enable = true,
      select = { "E", "F", "I", "B", "UP" },
      extendSelect = { "W" },
    },
  },
}
