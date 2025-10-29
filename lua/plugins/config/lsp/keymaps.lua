-- LSP Keymaps Configuration
local M = {}

function M.setup()
  -- Setup keymaps when LSP attaches to a buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach-keymaps', { clear = true }),
    callback = function(event)
      -- Helper function to define keymaps
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Navigation keymaps
      map('<leader>cd', require('telescope.builtin').lsp_definitions, '[C]ode [D]efinition')
      map('<leader>cr', require('telescope.builtin').lsp_references, '[C]ode [R]eferences')
      map('<leader>ci', require('telescope.builtin').lsp_implementations, '[C]ode [I]mplementation')
      map('<leader>ct', require('telescope.builtin').lsp_type_definitions, '[C]ode [T]ype definition')
      map('<leader>cD', vim.lsp.buf.declaration, '[C]ode [D]eclaration')

      -- Symbol operations
      map('<leader>cf', vim.lsp.buf.rename, '[C]ode Re[f]actor')
      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
      map('<leader>cs', require('telescope.builtin').lsp_document_symbols, '[C]ode [S]ymbols')
      map('<leader>cS', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[C]ode workspace [S]ymbols')

      -- Documentation
      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      map('<M-k>', vim.lsp.buf.signature_help, 'Signature help')
      map('<leader>ch', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, '[C]ode [H]int toggle')

      -- Formatting
      map('<leader>f', function()
        vim.lsp.buf.format { async = true }
      end, '[F]ormat buffer')
    end,
  })

  -- LSP reload function
  local function reload_lsp()
    local clients = vim.lsp.get_clients()
    if #clients == 0 then
      print 'No LSP clients running'
      return
    end

    for _, client in ipairs(clients) do
      vim.lsp.stop_client(client.id)
    end

    vim.defer_fn(function()
      vim.cmd 'LspStart'
      print 'LSP servers reloaded'
    end, 500)
  end

  -- Reload LSP keybind
  vim.keymap.set('n', '<leader>cR', reload_lsp, { desc = 'LSP: [C]ode [R]eload LSP servers' })

  -- Diagnostic keymaps (available globally, not just when LSP attaches)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
end

return M
