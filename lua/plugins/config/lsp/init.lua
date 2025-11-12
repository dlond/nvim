-- LSP Configuration Module
local M = {}

function M.setup()
  -- Get capabilities from blink.cmp if available
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local ok, blink_cmp = pcall(require, 'blink.cmp')
  if ok then
    capabilities = blink_cmp.get_lsp_capabilities(capabilities)
  end

  -- Set global position encoding preference
  capabilities.general.positionEncodings = { 'utf-16' }

  -- Load server configurations
  local servers = require('plugins.config.lsp.servers').get_servers()

  -- Setup each server with capabilities
  for name, config in pairs(servers) do
    config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
    vim.lsp.config(name, config)
    vim.lsp.enable(name) -- Actually start the server!
  end

  -- Setup LSP keymaps
  require('plugins.config.lsp.keymaps').setup()

  vim.diagnostic.config {
    virtual_text = {
      source = true,
      prefix = '●',
    },
    float = {
      source = true,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  }

  vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', {})
end

return M
