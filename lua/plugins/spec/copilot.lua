-- GitHub Copilot integration
return {
  'zbirenbaum/copilot.lua',
  enabled = vim.g.copilot_enabled == true, -- Only load if enabled by Nix
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    panel = {
      layout = { position = 'right' },
    },
  },
}
