
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    -- 1. Capability Overrides
    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.definitionProvider = false
    end

    -- 2. CodeLens
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
      vim.lsp.codelens.enable(true, { bufnr = ev.buf })
    end

    -- 3. Native Completion
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.o.complete = "o,.,w,b,u"
      vim.o.completeopt = "menu,menuone,noinsert,fuzzy,popup"
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set("i", "<C-Space>", function()
        vim.lsp.completion.get()
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({async = false})
  end,
})

