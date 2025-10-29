-- Auto-pairs - Automatically close brackets, quotes, etc.
return {
  'windwp/nvim-autopairs',
  config = function()
    require('plugins.config.autopairs').setup()
  end,
}
