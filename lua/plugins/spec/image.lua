-- Render images in neovim
return {
  '3rd/image.nvim',
  build = false,
  config = function()
    require('plugins.config.image').setup()
  end,
}
