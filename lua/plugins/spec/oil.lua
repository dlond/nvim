return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    { '<leader>-', '<cmd>Oil .<cr>', desc = 'Open current directory' },
  },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, _)
        return vim.startswith(name, '.')
      end,
    },
    keymaps = {
      ['<C-h>'] = false,
      ['<C-j>'] = false,
      ['<C-k>'] = false,
      ['<C-l>'] = false,
    },
  },
}
