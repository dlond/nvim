-- Molten - Jupyter notebook support in Neovim
return {
  'benlubas/molten-nvim',
  version = '^1.0.0',
  dependencies = { '3rd/image.nvim' },
  build = ':UpdateRemotePlugins',
  init = function()
    -- Basic settings
    vim.g.molten_image_provider = 'image.nvim'
    vim.g.molten_output_win_max_height = 20
    vim.g.molten_auto_open_output = true
    vim.g.molten_wrap_output = true
    vim.g.molten_virt_text_output = true
  end,
  config = function()
    -- Delegate to config file for complex setup
    require('plugins.config.molten')
  end,
}
