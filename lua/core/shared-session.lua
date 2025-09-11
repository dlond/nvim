-- lua/core/shared-session.lua
-- Protection for shared tmux nvim sessions

local M = {}

-- Check if we're in a shared tmux session
local function is_shared_session()
  local tmux = vim.env.TMUX
  if not tmux or tmux == '' then
    return false
  end

  local handle = io.popen "tmux display-message -p '#{session_name}' 2>/dev/null"
  if handle then
    local session_name = handle:read('*a'):gsub('\n', '')
    handle:close()
    return session_name:match '%-nvim%-shared$' ~= nil
  end
  return false
end

-- Create wrapper commands that check before quitting
local function create_quit_command(cmd_name, vim_cmd)
  vim.api.nvim_create_user_command(cmd_name, function(opts)
    if is_shared_session() then
      local response = vim.fn.input '⚠️  Closing shared nvim session! Confirm with y/Y: '
      if response:lower() ~= 'y' then
        print '\nQuit cancelled'
        return
      end
    end
    local cmd = vim_cmd .. (opts.bang and '!' or '')
    vim.cmd(cmd)
  end, { bang = true })
end

function M.setup()
  -- Override the common quit commands
  vim.cmd [[
    cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Q' : 'q')<CR>
    cabbrev qa <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Qa' : 'qa')<CR>
    cabbrev wq <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Wq' : 'wq')<CR>
    cabbrev x <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'X' : 'x')<CR>
  ]]

  -- Create the wrapper commands
  create_quit_command('Q', 'q')
  create_quit_command('Qa', 'qa')
  create_quit_command('Wq', 'wq')
  create_quit_command('X', 'x')

  -- Override ZZ and ZQ keymaps
  vim.keymap.set('n', 'ZZ', function()
    if is_shared_session() then
      local response = vim.fn.input '⚠️  Closing shared nvim session! Confirm with y/Y: '
      if response:lower() ~= 'y' then
        print '\nQuit cancelled'
        return
      end
    end
    vim.cmd 'wq'
  end, { desc = 'Save and quit with shared session check' })

  vim.keymap.set('n', 'ZQ', function()
    if is_shared_session() then
      local response = vim.fn.input '⚠️  Closing shared nvim session! Confirm with y/Y: '
      if response:lower() ~= 'y' then
        print '\nQuit cancelled'
        return
      end
    end
    vim.cmd 'q!'
  end, { desc = 'Quit without saving with shared session check' })
end

return M
