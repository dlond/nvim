-- Auto-pairs - Automatically close brackets, quotes, etc.
return {
  'saghen/blink.pairs',
  version = '0.4.0',
  dependencies = 'saghen/blink.download',
  config = function()
    require('plugins.config.autopairs').setup()
  end,
}
