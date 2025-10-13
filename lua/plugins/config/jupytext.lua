-- Jupytext configuration
local M = {}

function M.setup()
  -- Basic settings
  vim.g.jupytext_fmt = 'py:percent'
  vim.g.jupytext_command = 'jupytext'
  
  -- Create user commands
  local function create_commands()
    vim.api.nvim_create_user_command('JupytextSync', function()
      vim.cmd('!jupytext --sync %')
      vim.notify("Notebook synced", vim.log.levels.INFO)
    end, { desc = "Sync current file with its notebook pair" })
    
    vim.api.nvim_create_user_command('JupytextPair', function()
      vim.cmd('!jupytext --set-formats ipynb,py:percent %')
      vim.notify("Notebook paired with .py file", vim.log.levels.INFO)
    end, { desc = "Pair notebook with Python file" })
    
    vim.api.nvim_create_user_command('JupytextConvert', function(opts)
      local format = opts.args ~= "" and opts.args or "py:percent"
      vim.cmd('!jupytext --to ' .. format .. ' %')
      vim.notify("Converted to " .. format, vim.log.levels.INFO)
    end, { 
      nargs = '?',
      desc = "Convert notebook to format (default: py:percent)",
      complete = function()
        return { 'py:percent', 'md', 'py:light', 'py:sphinx', 'jl:percent', 'r:percent' }
      end
    })
  end
  
  -- Setup auto-sync for paired files
  local function setup_autosync()
    local augroup = vim.api.nvim_create_augroup("JupytextSync", { clear = true })
    
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      pattern = { "*.py", "*.ipynb", "*.md", "*.jl", "*.r" },
      callback = function()
        local file = vim.fn.expand('%:p')
        local bufnr = vim.api.nvim_get_current_buf()
        
        -- Check if file has jupytext pairing metadata
        local first_lines = vim.api.nvim_buf_get_lines(bufnr, 0, 15, false)
        local has_pairing = false
        
        for _, line in ipairs(first_lines) do
          if line:match("jupytext:") and line:match("formats:") then
            has_pairing = true
            break
          end
        end
        
        if has_pairing then
          -- Run sync in background
          vim.fn.jobstart({'jupytext', '--sync', file}, {
            on_exit = function(_, exit_code)
              if exit_code == 0 then
                vim.schedule(function()
                  vim.notify("Jupytext: Synced with notebook", vim.log.levels.INFO)
                end)
              end
            end
          })
        end
      end,
      desc = "Auto-sync Jupytext paired files"
    })
  end
  
  -- Setup keymaps
  local function setup_keymaps()
    -- Only set these in relevant filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "markdown", "julia", "r" },
      callback = function()
        local opts = { buffer = true, silent = true }
        vim.keymap.set("n", "<leader>js", ":JupytextSync<CR>", 
          vim.tbl_extend("force", opts, { desc = "Sync with notebook" }))
        vim.keymap.set("n", "<leader>jp", ":JupytextPair<CR>", 
          vim.tbl_extend("force", opts, { desc = "Pair with notebook" }))
        vim.keymap.set("n", "<leader>jc", ":JupytextConvert ", 
          vim.tbl_extend("force", opts, { desc = "Convert to format" }))
      end
    })
  end
  
  -- Integration with Molten
  local function setup_molten_integration()
    -- When opening .ipynb files, offer to convert
    vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
      pattern = "*.ipynb",
      callback = function()
        local file = vim.fn.expand('%:p')
        local py_file = file:gsub('%.ipynb$', '.py')
        
        -- Check if .py version exists
        if vim.fn.filereadable(py_file) == 1 then
          -- Close the current buffer and open the .py version
          vim.cmd('buffer #')  -- Go to alternate buffer
          vim.cmd('bdelete! #')  -- Delete the ipynb buffer
          vim.cmd('edit ' .. py_file)
          vim.notify("Opened paired .py file instead of .ipynb", vim.log.levels.INFO)
        else
          -- Offer to convert
          vim.schedule(function()
            vim.ui.select(
              { "Convert to .py", "Keep as JSON" },
              { prompt = "Convert notebook to Python?" },
              function(choice)
                if choice == "Convert to .py" then
                  local result = vim.fn.system('jupytext --to py:percent "' .. file .. '"')
                  if vim.v.shell_error == 0 then
                    vim.cmd('edit! ' .. py_file)
                    vim.notify("Converted and opened as .py", vim.log.levels.INFO)
                  else
                    vim.notify("Failed to convert: " .. result, vim.log.levels.ERROR)
                  end
                end
              end
            )
          end)
        end
      end,
      desc = "Handle .ipynb files with Jupytext"
    })
  end
  
  -- Initialize all components
  create_commands()
  setup_autosync()
  setup_keymaps()
  setup_molten_integration()
end

-- Run setup
M.setup()

return M