return {
  {
    'saghen/blink.cmp',
    version = 'v0.*', -- Use stable releases
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
      require('plugins.config.completion').setup_blink()
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    enabled = vim.g.copilot_enabled,
    event = 'InsertEnter',
    config = function()
      require('plugins.config.completion').setup_copilot()
    end,
  },
  {
    'saghen/blink-cmp-copilot',
    enabled = vim.g.copilot_enabled,
    dependencies = { 'saghen/blink.cmp', 'zbirenbaum/copilot.lua' },
    config = function()
      require('plugins.config.completion').setup_blink_copilot()
    end,
  },
}
