return {
  {
    'mrcjkb/rustaceanvim',
    version = '^9',
    lazy = false,
    init = function()
      require('plugins.config.rustaceanvim').init()
    end,
  },
}
