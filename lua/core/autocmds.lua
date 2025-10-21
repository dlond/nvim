-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Fix for netrw not properly detecting filetypes
-- This is a global issue that affects all filetypes when using :Ex
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup('netrw-filetype-fix', { clear = true }),
  pattern = "*",
  callback = function()
    -- If filetype is empty after opening a file, force detection
    -- This commonly happens when navigating through netrw
    if vim.bo.filetype == "" then
      vim.schedule(function()
        if vim.bo.filetype == "" then
          vim.cmd("filetype detect")
        end
      end)
    end
  end,
  desc = "Fix netrw filetype detection for all files"
})
