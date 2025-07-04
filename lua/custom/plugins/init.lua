-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-tree/nvim-web-devicons',
    lazy = false,
    priority = 1000,
    config = function()
      require('nvim-web-devicons').setup()
    end,
  },
  -- { import = 'custom.plugins.completion' },
  -- { import = 'custom.plugins.debug' },
  -- { import = 'custom.plugins.formatting' },
  { import = 'custom.plugins.lsp' },
  -- { import = 'custom.plugins.nvim-tmux-navigator' },
  -- { import = 'custom.plugins.telescope' },
  -- { import = 'custom.plugins.theme' },
  -- { import = 'custom.plugins.treesitter' },
}
