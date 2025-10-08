local M = {}

function M.setup()
  -- Keybindings
  local map = vim.keymap.set

  map('n', '<leader>mi', ':MoltenInit<CR>', { desc = 'Molten: Initialize' })
  map('n', '<leader>me', ':MoltenEvaluateOperator<CR>', { desc = 'Molten: Evaluate operator' })
  map('n', '<leader>ml', ':MoltenEvaluateLine<CR>', { desc = 'Molten: Evaluate line' })
  map('n', '<leader>mr', ':MoltenReevaluateCell<CR>', { desc = 'Molten: Re-evaluate cell' })
  map('v', '<leader>me', ':<C-u>MoltenEvaluateVisual<CR>gv', { desc = 'Molten: Evaluate visual' })
  map('n', '<leader>md', ':MoltenDelete<CR>', { desc = 'Molten: Delete cell' })
  map('n', '<leader>mo', ':MoltenShowOutput<CR>', { desc = 'Molten: Show output' })
  map('n', '<leader>mh', ':MoltenHideOutput<CR>', { desc = 'Molten: Hide output' })
  map('n', '<leader>mx', ':MoltenInterrupt<CR>', { desc = 'Molten: Interrupt kernel' })
end

return M
