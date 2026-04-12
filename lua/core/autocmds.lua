vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
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
    vim.keymap.set("n", "<leader>lt", function() MiniExtra.pickers.lsp({ scope = 'type_definition' }) end, opts)
    vim.keymap.set("n", "<leader>ls", function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end, opts)
    -- Diagnostic picker (Extra's version is often more feature-rich)
    vim.keymap.set("n", "<leader>dd", function() MiniExtra.pickers.diagnostic({ scope = 'all' }) end, opts)

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

  end,
})
