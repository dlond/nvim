vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
})

local py_base = {
  capabilities = {
    offsetEncoding = { "utf-16" },
    general = {
      positionEncodings = { "utf-16" },
    },
  },
}

vim.lsp.config(
  "basedpyright",
  vim.tbl_deep_extend("force", py_base, {
    settings = {
      basedpyright = {
        disableOrganizeImports = true,
        analysis = {
          typeCheckingMode = "standard",
          diagnosticSeverityOverrides = {
            reportUnusedImport = "none",
            reportUnusedVariable = "none",
            reportUndefinedVariable = "none",
          },
        },
      },
    },
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  })
)

vim.lsp.config(
  "ruff",
  vim.tbl_deep_extend("force", py_base, {
    on_init = function(client)
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.renameProvider = false
      client.server_capabilities.referencesProvider = false
      client.server_capabilities.documentSymbolProvider = false
      client.server_capabilities.definitionProvider = false
    end,
  })
)

vim.lsp.enable("lua_ls")
vim.lsp.enable("basedpyright")
vim.lsp.enable("ruff")
vim.lsp.enable("clangd")
vim.lsp.enable("cmake")
vim.lsp.enable("nixd")

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = {
    current_line = true,
  },
  severity_sort = true,
})


