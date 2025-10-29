local M = {}

function M.setup()
  -- Keybindings
  local map = vim.keymap.set

  map('n', '<leader>Mi', ':MoltenInit<CR>', { desc = 'Molten: Initialize' })
  map('n', '<leader>Me', ':MoltenEvaluateOperator<CR>', { desc = 'Molten: Evaluate operator' })
  map('v', '<leader>Me', ':<C-u>MoltenEvaluateVisual<CR>gv', { desc = 'Molten: Evaluate visual' })
  map('n', '<leader>Ml', ':MoltenEvaluateLine<CR>', { desc = 'Molten: Evaluate line' })
  map('n', '<leader>Mr', ':MoltenReevaluateCell<CR>', { desc = 'Molten: Re-evaluate cell' })
  map('n', '<leader>Md', ':MoltenDelete<CR>', { desc = 'Molten: Delete cell' })
  map('n', '<leader>Mo', ':MoltenShowOutput<CR>', { desc = 'Molten: Show output' })
  map('n', '<leader>Mh', ':MoltenHideOutput<CR>', { desc = 'Molten: Hide output' })
  map('n', '<leader>Mx', ':MoltenInterrupt<CR>', { desc = 'Molten: Interrupt kernel' })
end

return M
