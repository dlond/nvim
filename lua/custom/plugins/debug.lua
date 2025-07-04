-- ~/dlond/nvim/lua/custom/plugins/debug.lua
-- Debug Adapter Protocol (DAP) setup, integrating kickstart's UI preferences

return {
  -- Main DAP plugin
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- UI for nvim-dap
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' }, -- nvim-dap-ui often needs nio
        config = function()
          local asyn = require 'plenary.async'
          local dapui = require 'dapui'
          dapui.setup {
            -- Borrowed icon and control settings from kickstart/plugins/debug.lua
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
              icons = {
                pause = '⏸',
                play = '▶',
                step_into = '⏎',
                step_over = '⏭',
                step_out = '⏮',
                step_back = 'b', -- Kickstart uses 'b', nvim-dap default might be different
                run_last = '▶▶',
                terminate = '⏹',
                disconnect = '⏏',
              },
            },
            -- You can customize layouts, floating window behavior, etc.
            -- layouts = { ... },
            -- floating = { ... },
          }

          -- Automatically open/close dapui when DAP session starts/stops
          local dap = require 'dap'

          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
          end
        end,
      },
      -- Optional: Virtual text for DAP (shows variable values inline)
      -- { 'theHamsta/nvim-dap-virtual-text', opts = {} },

      -- If you need Go debugging, you would add 'leoluz/nvim-dap-go' here
      -- and call its setup in the nvim-dap config function.
      -- { 'leoluz/nvim-dap-go' },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      local async = require 'plenary.async'

      -- Configure the LLDB DAP adapter for C/C++
      -- Assumes 'lldb-dap' executable is in PATH (from pkgs.llvmPackages_XX.lldb)
      dap.adapters.lldb = {
        type = 'executable',
        command = 'lldb-dap',
        name = 'lldb-dap (Nix)',
      }

      dap.configurations.cpp = {
        {
          name = 'Launch C/C++ (lldb-dap)',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            --   local utils = require 'custom.utils'
            --   local target = utils:get_target()
            --   return utils.pick_executable(vim.fn.getcwd() .. '/' .. target)
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          -- Ensure your C/C++ project is compiled with debug symbols (e.g., -g flag with clang/gcc)
        },
      }
      dap.configurations.c = dap.configurations.cpp -- Use same config for C

      -- Python DAP configuration (using debugpy)
      -- Ensure python3Packages.debugpy is in your home.packages
      dap.adapters.python = {
        type = 'executable',
        command = 'python', -- Should be the python from your Nix env
        args = { '-m', 'debugpy.adapter' },
      }
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch Python file',
          program = '${file}', -- Debug the current file
          pythonPath = function()
            local venv = os.getenv 'VIRTUAL_ENV'
            if venv then
              return venv .. '/bin/python'
            end
            -- Fallback to trying to find python3, then python in PATH
            -- This could be made more robust by getting python path from Nix if needed
            local py3 = vim.fn.executable 'python3'
            if py3 ~= 0 and py3 ~= '' then
              return py3
            end
            return 'python'
          end,
        },
      }

      -- If you added 'leoluz/nvim-dap-go' as a dependency:
      -- require('dap-go').setup() -- Call its setup function

      -- Launch and Control
      vim.keymap.set('n', '<leader>dc', function()
        async.run(function()
          dap.continue()
          if not dapui.windows or vim.tbl_isempty(dapui.windows) then
            dapui.open()
          end
        end)
      end, { desc = 'DAP: [C]ontinue show UI (async-safe)' })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'DAP: Toggle [B]reakpoint' })
      vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'DAP: Run [L]ast' })

      -- DAP: Stepping
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'DAP: Step [I]nto' })
      vim.keymap.set('n', '<leader>dk', dap.step_over, { desc = 'DAP: Step [O]ver (k)' })
      vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'DAP: Step [O]ut' })
      vim.keymap.set('n', '<leader>dx', function()
        async.run(function()
          dap.run_to_cursor()
        end)
      end, { desc = 'DAP: Run to Cursor (x) (asyn-safe)' })

      -- DAP: Termination
      vim.keymap.set('n', '<leader>dt', function()
        async.run(function()
          dap.terminate()
          dapui.close()
        end)
      end, { desc = 'DAP: [T]erminate (async-safe)' })

      -- DAP: UI
      vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'DAP: Open [R]EPL' })
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'DAP: Toggle [U]I' })
    end,
  },
}
