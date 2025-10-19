-- LeetCode configuration
local M = {}

M.setup = function()
  require('leetcode').setup({
    lang = 'python3', -- Default to Python for initial solving
    
    -- Alternative languages
    alternate = {
      'cpp',
      'python3',
    },
    
    storage = {
      home = vim.fn.stdpath('data') .. '/leetcode',
      cache = vim.fn.stdpath('cache') .. '/leetcode',
    },
    
    -- Auto-disable Copilot in LeetCode buffers
    hooks = {
      ['enter'] = {
        function()
          -- Disable Copilot when entering LeetCode problems
          vim.cmd('Copilot disable')
          vim.notify('Copilot disabled for LeetCode practice', vim.log.levels.INFO)
        end,
      },
      ['question_leave'] = {
        function()
          -- Re-enable Copilot when leaving LeetCode
          vim.cmd('Copilot enable')
        end,
      },
    },
    
    injector = {
      ['python3'] = {
        before = [[
# No external libraries
# Focus on clean, efficient solutions
        ]],
      },
      ['cpp'] = {
        before = [[
#include <bits/stdc++.h>
using namespace std;

// C++ practice
// Focus on low-latency patterns
        ]],
      },
    },
    
    keys = {
      toggle = { 'q', '<Esc>' },
      confirm = { '<CR>' },
      reset_testcases = 'r',
      use_testcase = 'U',
      focus_testcases = 'H',
      focus_result = 'L',
    },
  })
  
  -- Keymaps for LeetCode
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  
  keymap('n', '<leader>lq', '<cmd>Leet tabs<cr>', vim.tbl_extend('force', opts, { desc = 'LeetCode tabs' }))
  keymap('n', '<leader>lm', '<cmd>Leet menu<cr>', vim.tbl_extend('force', opts, { desc = 'LeetCode menu' }))
  keymap('n', '<leader>lc', '<cmd>Leet console<cr>', vim.tbl_extend('force', opts, { desc = 'LeetCode console' }))
  keymap('n', '<leader>li', '<cmd>Leet info<cr>', vim.tbl_extend('force', opts, { desc = 'LeetCode info' }))
  keymap('n', '<leader>ll', '<cmd>Leet lang<cr>', vim.tbl_extend('force', opts, { desc = 'LeetCode language' }))
  keymap('n', '<leader>ld', '<cmd>Leet desc<cr>', vim.tbl_extend('force', opts, { desc = 'LeetCode description' }))
  keymap('n', '<leader>lr', '<cmd>Leet run<cr>', vim.tbl_extend('force', opts, { desc = 'LeetCode run' }))
  keymap('n', '<leader>ls', '<cmd>Leet submit<cr>', vim.tbl_extend('force', opts, { desc = 'LeetCode submit' }))
  keymap('n', '<leader>lt', '<cmd>Leet test<cr>', vim.tbl_extend('force', opts, { desc = 'LeetCode test' }))
  keymap('n', '<leader>ly', '<cmd>Leet yank<cr>', vim.tbl_extend('force', opts, { desc = 'LeetCode yank' }))
  keymap('n', '<leader>lo', '<cmd>Leet open<cr>', vim.tbl_extend('force', opts, { desc = 'LeetCode open in browser' }))
  keymap('n', '<leader>lR', '<cmd>Leet restore<cr>', vim.tbl_extend('force', opts, { desc = 'LeetCode restore' }))
  
  -- Daily practice reminder
  keymap('n', '<leader>lD', function()
    local problems = {
      Monday = 'Dynamic Programming',
      Tuesday = 'Graphs',
      Wednesday = 'Math/Probability', 
      Thursday = 'Trees/Recursion',
      Friday = 'Bit Manipulation',
      Saturday = 'Jane Street Tagged',
      Sunday = 'Jane Street Tagged',
    }
    local day = os.date('%A')
    vim.notify('Today\'s focus: ' .. problems[day], vim.log.levels.INFO)
  end, vim.tbl_extend('force', opts, { desc = 'LeetCode daily focus' }))
end

return M
