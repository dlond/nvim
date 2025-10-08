-- Jupyter/Notebook Integration

return {
  -- Molten.nvim - Jupyter integration for Neovim
  {
    'benlubas/molten-nvim',
    version = '^1.0.0',
    dependencies = { '3rd/image.nvim' },
    build = ':UpdateRemotePlugins',
    init = function()
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    config = function()
      require('plugins.config.molten').setup()
    end,
  },

  -- image.nvim - Image rendering for Neovim
  {
    '3rd/image.nvim',
    opts = {
      backend = 'kitty',
      integrations = {},
      max_height_window_percentage = 50,
    },
  },
}
