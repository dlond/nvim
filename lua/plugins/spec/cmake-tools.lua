return {
  'Civitasv/cmake-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/overseer.nvim',
  },
  config = function()
    require('plugins.config.cmake-tools').setup()
  end,
}
