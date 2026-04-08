return {
  'mm4cN/nvim-conan',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('plugins.config.nvim-conan').setup()
  end,
}
