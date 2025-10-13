-- Render images in neovim
return {
  '3rd/image.nvim',
  build = false,
  opts = {
    processor = 'magick_cli',
  },
}
