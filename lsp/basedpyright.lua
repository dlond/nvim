---@type vim.lsp.Config
return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "pyrightconfig.json",
    ".git",
  },
  ---@type lspconfig.settings.basedpyright
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        diagnosticSeverityOverrides = {
          reportUnusedImport = "none",
          reportDuplicateImport = "none",
          reportUnusedVariable = "none",
        },
      },
    },
  },
}
