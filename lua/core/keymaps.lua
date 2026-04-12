-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear search highlights with Escape in normal mode
-- vim.keymap.set("n", "<Esc>", [[<Cmd>nohlsearch<CR>]])

-- Exit terminal mode with double Escape
vim.keymap.set("t", "<Esc><Esc>", [[<C-\\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>cx", [[<Cmd>:.lua<CR>]], { desc = "Execute current line" })

-- Buffer management keymaps
-- vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { desc = "[B]rowse [B]uffers" })
-- vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
-- vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "[B]uffer [D]elete" })
-- vim.keymap.set("n", "<leader>ba", "<cmd>%bd|e#<CR>", { desc = "[B]uffers close [A]ll but current" })
-- vim.keymap.set("n", "<leader>bn", "<cmd>enew<CR>", { desc = "[B]uffer [N]ew" })

-- Quick buffer switching with numbers
-- for i = 1, 9 do
--   vim.keymap.set("n", "<leader>" .. i, "<cmd>buffer " .. i .. "<CR>", { desc = "Switch to buffer " .. i })
-- end

-- Window management keymaps
vim.keymap.set("n", "<leader>ws", "<cmd>split<CR>", { desc = "[W]indow [S]plit horizontal" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "[W]indow [V]ertical split" })
vim.keymap.set("n", "<leader>wc", "<cmd>close<CR>", { desc = "[W]indow [C]lose" })
vim.keymap.set("n", "<leader>wo", "<cmd>only<CR>", { desc = "[W]indow [O]nly (close others)" })
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "[W]indow cycle" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "[W]indow balance sizes" })

-- Window resizing with arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Editing/Navigation
-- vim.keymap.set("n", "<leader>S", ":%s/<C-r><C-w>/", { desc = "[S]ubstitute current word" })

-- Floating terminal
-- local float_term = require('core.float_term')
--
-- vim.keymap.set('n', '<leader>tf', function() float_term.open() end, { desc = '[T]erminal [F]loat' })
-- vim.keymap.set('n', '<leader>tx', function() float_term.reset() end, { desc = '[T]erminal kill/reset' })
-- vim.keymap.set('n', '<leader>tr', function()
--   vim.ui.input({ prompt = 'Run: ' }, function(input)
--     if input and input ~= '' then
--       float_term.open(input)
--     end
--   end)
-- end, { desc = '[T]erminal [R]un command' })

-- Code runner (auto-detects backend: cpp, python, etc.)
-- local code = require('core.code')
-- require('core.cpp_build') -- registers the cpp backend
-- require('core.python_run') -- registers the python backend
--
-- vim.keymap.set('n', '<leader>cc', function() code.go() end, { desc = '[C]ode [C]onfigure & run' })
-- vim.keymap.set('n', '<leader>cb', function() code.build() end, { desc = '[C]ode [B]uild' })
-- vim.keymap.set('n', '<leader>cr', function() code.run() end, { desc = '[C]ode [R]un' })
-- vim.keymap.set('n', '<leader>ct', function() code.test() end, { desc = '[C]ode [T]est' })
-- vim.keymap.set('n', '<leader>cs', function() code.status() end, { desc = '[C]ode [S]tatus' })
-- vim.keymap.set('n', '<leader>cx', function() code.reset() end, { desc = '[C]ode reset' })
--
