return {
  'saghen/blink.cmp',
  lazy = false, -- Lazy loading handled internally
  dependencies = {
    'rafamadriz/friendly-snippets',
    'giuxtaposition/blink-cmp-copilot',
    'zbirenbaum/copilot.lua',
  },
  version = 'v0.*', -- Use stable releases
  config = function()
    require('plugins.config.blink').setup()
  end,
}
