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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local opts = { buffer = ev.buf }

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set("i", "<c-space>", function()
        vim.lsp.completion.get()
      end, opts)
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
      vim.lsp.codelens.enable(true, { bufnr = ev.buf })
      vim.keymap.set("n", "<Leader>cl", vim.lsp.codelens.run, opts)
    end

    vim.keymap.set("n", "<leader>ld", function() MiniExtra.pickers.lsp({ scope = 'definition' }) end, opts)
    vim.keymap.set("n", "<leader>lr", function() MiniExtra.pickers.lsp({ scope = 'references' }) end, opts)
    vim.keymap.set("n", "<leader>li", function() MiniExtra.pickers.lsp({ scope = 'implementation' }) end, opts)
    vim.keymap.set("n", "<leader>ls", function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end, opts)
    -- Diagnostic picker (Extra's version is often more feature-rich)
    vim.keymap.set("n", "<leader>dd", function() MiniExtra.pickers.diag({ scope = 'all' }) end, opts)

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  end,
})

