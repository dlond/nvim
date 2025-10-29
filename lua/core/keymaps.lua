-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear search highlights with Escape in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode with double Escape
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- NOTE: Window navigation is handled by nvim-tmux-navigator plugin
-- which provides seamless navigation between vim splits and tmux panes

-- Buffer management keymaps
vim.keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<CR>', { desc = '[B]rowse [B]uffers' })
vim.keymap.set('n', '[b', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>ba', '<cmd>%bd|e#<CR>', { desc = '[B]uffers close [A]ll but current' })
vim.keymap.set('n', '<leader>bn', '<cmd>enew<CR>', { desc = '[B]uffer [N]ew' })

-- Quick buffer switching with numbers
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, '<cmd>buffer ' .. i .. '<CR>', { desc = 'Switch to buffer ' .. i })
end

-- Window management keymaps
vim.keymap.set('n', '<leader>ws', '<cmd>split<CR>', { desc = '[W]indow [S]plit horizontal' })
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = '[W]indow [V]ertical split' })
vim.keymap.set('n', '<leader>wc', '<cmd>close<CR>', { desc = '[W]indow [C]lose' })
vim.keymap.set('n', '<leader>wo', '<cmd>only<CR>', { desc = '[W]indow [O]nly (close others)' })
vim.keymap.set('n', '<leader>ww', '<C-w>w', { desc = '[W]indow cycle' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = '[W]indow balance sizes' })

-- Window resizing with arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Editing
vim.keymap.set('n', '<leader>S', ':%s/<C-r><C-w>/', { desc = '[S]ubstitute current word' })

-- Standard practice for Lua modules that don't need to return complex data
return {}
