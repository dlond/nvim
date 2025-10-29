-- Treesitter - Syntax highlighting and text objects
return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'cmake',
      'cpp',
      'diff',
      'html',
      'lua',
      'luadoc',
      'make',
      'markdown',
      'markdown_inline',
      'nix',
      'python',
      'query',
      'vim',
      'vimdoc',
      'yaml',
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        node_incremental = 'grn',
        scope_incremental = 'grc',
        node_decremental = 'grm',
      },
    },
  },
}

