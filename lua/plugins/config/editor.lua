-- Editor Enhancement Configuration
local M = {}

function M.setup_floaterm()
  vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

  local state = {
    floating = {
      buf = -1,
      win = -1,
    },
  }

  local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    -- Calculate the position to center the window
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
      buf = opts.buf
    else
      buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    -- Define window configuration
    local win_config = {
      relative = 'editor',
      width = width,
      height = height,
      col = col,
      row = row,
      style = 'minimal', -- No borders or extra UI elements
      border = 'rounded',
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
  end

  local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
      state.floating = create_floating_window { buf = state.floating.buf }
      if vim.bo[state.floating.buf].buftype ~= 'terminal' then
        vim.cmd.terminal()
      end
    else
      vim.api.nvim_win_hide(state.floating.win)
    end
  end

  -- Example usage:
  -- Create a floating window with default dimensions
  vim.api.nvim_create_user_command('Floaterm', toggle_terminal, {})
end

function M.setup_mini()
  -- Better Around/Inside textobjects
  require('mini.ai').setup { n_lines = 500 }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  require('mini.surround').setup()

  -- Simple and easy statusline
  local statusline = require 'mini.statusline'
  statusline.setup { use_icons = vim.g.have_nerd_font }

  -- Custom statusline location section
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function()
    return '%2l:%-2v'
  end
end

function M.setup_illuminate()
  require('illuminate').configure {
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { 'lsp' },
    },
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    filetypes_denylist = {
      'dirbuf',
      'dirvish',
      'fugitive',
      'alpha',
      'NvimTree',
      'lazy',
      'neogitstatus',
      'Trouble',
      'lir',
      'Outline',
      'spectre_panel',
      'toggleterm',
      'DressingSelect',
      'TelescopePrompt',
    },
    under_cursor = true,
  }
end

function M.setup()
  M.setup_floaterm()
  M.setup_mini()
  M.setup_illuminate()
end

return M
