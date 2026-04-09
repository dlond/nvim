return {
  'saecki/crates.nvim',
  tag = 'stable',
  config = function()
    require('plugins.config.crates-nvim').setup()
  end,
}
