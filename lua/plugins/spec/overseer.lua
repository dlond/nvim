return {
  'stevearc/overseer.nvim',
  config = function()
    require('plugins.config.overseer').setup()
  end,
}
