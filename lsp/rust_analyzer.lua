config = {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml' },
  settings = {},
}

vim.lsp.config('rust-analyzer', config)
