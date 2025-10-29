-- Auto-pairs - Automatically close brackets, quotes, etc.
return {
  'saghen/blink.pairs',
  version = '*',
  dependencies = { 'saghen/blink.download' },
  config = function()
    require('plugins.config.autopairs').setup()
  end,
}
