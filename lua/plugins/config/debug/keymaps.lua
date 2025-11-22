-- Debug Keymaps Configuration
local M = {}

function M.setup()
  local dap = require 'dap'
  local dapui = require 'dapui'

  -- Start debugging
  vim.keymap.set('n', '<F4>', dap.run_last, { desc = 'Debug: Run Last' })

  vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })

  -- Toggle UI
  vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: Toggle UI' })

  -- Debugging controls
  vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
  vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
  vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
  vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'Debug: Terminate Session' })

  vim.keymap.set('n', '<leader>de', dapui.eval, { desc = 'Debug: Eval under cursor' })
  vim.keymap.set('v', '<leader>de', dapui.eval, { desc = 'Debug: Eval selection' })

  -- Breakpoint management
  vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
  vim.keymap.set('n', '<leader>dB', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = 'Debug: Set Conditional Breakpoint' })
  vim.keymap.set('n', '<leader>dL', function()
    dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
  end, { desc = 'Debug: Set Log Point' })

  -- REPL and additional features
  vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Debug: Open REPL' })

  -- Widget-based inspections
  vim.keymap.set('n', '<leader>dh', function()
    require('dap.ui.widgets').hover()
  end, { desc = 'Debug: Hover Variables' })

  vim.keymap.set('n', '<leader>ds', function()
    local widgets = require 'dap.ui.widgets'
    widgets.centered_float(widgets.scopes)
  end, { desc = 'Debug: View Scopes' })

  vim.keymap.set('n', '<leader>df', function()
    local widgets = require 'dap.ui.widgets'
    widgets.centered_float(widgets.frames)
  end, { desc = 'Debug: View Frames' })

  -- Create visual indicators for breakpoints
  vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointCondition', { text = '🟡', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointRejected', { text = '⭕', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = 'DapLogPoint', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = '▶️', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
end

return M
