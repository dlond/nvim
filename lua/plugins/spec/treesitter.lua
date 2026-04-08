-- Treesitter - Syntax highlighting and text objects
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  -- event = { 'BufReadPost', 'BufNewFile' },
  -- main = 'nvim-treesitter.configs',
  config = function()
    require('plugins.config.treesitter').setup()
  end,
}
