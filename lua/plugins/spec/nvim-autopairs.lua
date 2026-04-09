return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('plugins.config.nvim-autopairs').config()
  end,
}
