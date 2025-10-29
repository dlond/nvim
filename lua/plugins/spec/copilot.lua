-- GitHub Copilot integration
return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  build = ':Copilot auth',
  event = 'InsertEnter',
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
  },
}
