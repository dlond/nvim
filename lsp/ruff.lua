config = {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  settings = {
    configurationPreference = 'filesystemFirst',
    lineLength = 100,
    editor = {
      -- Let conform handle all format on saves
      formatOnSave = false,
    },
    lint = {
      enable = true,
      select = { 'E', 'F', 'I', 'B', 'UP' },
      extendSelect = { 'W' },
    },
  },
}

vim.lsp.config('ruff', config)
