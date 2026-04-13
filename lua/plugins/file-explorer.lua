vim.pack.add({"https://github.com/stevearc/oil.nvim"})

require("oil").setup({
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
  },
  keymaps = {
      ['<C-h>'] = false,
      ['<C-j>'] = false,
      ['<C-k>'] = false,
      ['<C-l>'] = false,
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "_", "<CMD>Oil .<CR>", { desc = "Open current directory" })
