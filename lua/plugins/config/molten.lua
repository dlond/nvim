-- Molten (Jupyter) configuration
local M = {}

-- Keybindings
local function setup_keymaps()
  local keymap = vim.keymap.set

  -- Basic operations
  keymap('n', '<leader>mi', ':MoltenInit<CR>', { desc = 'Molten Init', silent = true })
  keymap('n', '<leader>ml', ':MoltenEvaluateLine<CR>', { desc = 'Evaluate Line', silent = true })
  keymap('n', '<leader>mr', ':MoltenReevaluateCell<CR>', { desc = 'Re-evaluate Cell', silent = true })
  keymap('v', '<leader>mv', ':<C-u>MoltenEvaluateVisual<CR>gv', { desc = 'Evaluate Visual', silent = true })

  -- Additional useful keymaps
  keymap('n', '<leader>md', ':MoltenDelete<CR>', { desc = 'Delete Cell', silent = true })
  keymap('n', '<leader>mh', ':MoltenHideOutput<CR>', { desc = 'Hide Output', silent = true })
  keymap('n', '<leader>mo', ':noautocmd MoltenEnterOutput<CR>', { desc = 'Enter Output', silent = true })

  -- Better cell execution that always works
  keymap('n', '<leader>mc', function()
    -- Always use the operator approach for consistency
    -- This finds cell boundaries based on # %% markers
    vim.cmd 'MoltenEvaluateOperator'

    -- Send 'ip' (inner paragraph) which respects the cell markers
    local keys = vim.api.nvim_replace_termcodes('ip', true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
  end, { desc = 'Run Cell', silent = true })

  -- Alternative: Run and move to next cell
  keymap('n', '<leader>mn', function()
    vim.cmd 'MoltenEvaluateOperator'
    local keys = vim.api.nvim_replace_termcodes('ip', true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
    -- Move to next cell
    vim.fn.search('^# %%', 'W')
  end, { desc = 'Run Cell and Next', silent = true })

  -- Cell navigation
  keymap('n', ']c', ':MoltenNext<CR>', { desc = 'Next Cell', silent = true })
  keymap('n', '[c', ':MoltenPrev<CR>', { desc = 'Previous Cell', silent = true })
end

-- Setup autocommands
local function setup_autocmds()
  local augroup = vim.api.nvim_create_augroup('MoltenConfig', { clear = true })

  -- Auto-initialize for Python files
  vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = { 'python' },
    callback = function()
      vim.keymap.set('n', '<leader>ms', function()
        vim.cmd 'MoltenInit python3'
        vim.notify('Molten kernel started', vim.log.levels.INFO)
      end, { buffer = true, desc = 'Start Python Kernel' })

      -- Auto-detect notebook files with cell markers
      vim.schedule(function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        for _, line in ipairs(lines) do
          if line:match '^# %%' then
            vim.notify('Notebook detected. Use <leader>ms to start kernel', vim.log.levels.INFO)
            break
          end
        end
      end)
    end,
  })

  -- Better notebook file handling
  vim.api.nvim_create_autocmd('BufRead', {
    group = augroup,
    pattern = { '*.ipynb' },
    callback = function()
      -- Consider using jupytext for better .ipynb handling
      vim.notify('Notebook file detected. Use :MoltenInit to start kernel', vim.log.levels.INFO)
    end,
  })
end

-- Main setup function
function M.setup()
  -- Tell Molten about cell delimiters
  vim.g.molten_cell_delimiter = '^# %%'

  setup_keymaps()
  setup_autocmds()
end

-- Initialize
M.setup()

return M
