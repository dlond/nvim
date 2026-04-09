local M = {}

function M.init()
  vim.g.rustaceanvim = {
    tools = {},
    server = {
      on_attach = function(client, bufnr)
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        local opts = { buffer = bufnr, silent = true }

        vim.keymap.set('n', 'K', function()
          vim.cmd.RustLsp { 'hover', 'actions' }
        end, opts)

        vim.keymap.set('n', '<leader>ca', function()
          vim.cmd.RustLsp 'codeAction'
        end, opts)

        vim.keymap.set('n', '<leader>ee', function()
          vim.cmd.RustLsp 'explainError'
        end, opts)
      end,
      default_settings = {
        ['rust-analyzer'] = {
          checkOnSave = {
            command = 'clippy',
          },
          inlayHints = {
            bindingModeHints = { enable = true },
            chainingHints = { enable = true },
            closingBraceHints = { enable = true },
            parameterHints = { enable = true },
            typeHints = { enable = true },
          },
        },
      },
    },
    dap = {},
  }
end

return M
