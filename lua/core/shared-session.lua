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

-- Check if any buffers have unsaved changes
local function has_unsaved_changes()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified then
      return true
    end
  end
  return false
end

-- Create wrapper commands that check before quitting
local function create_quit_command(cmd_name, vim_cmd)
  vim.api.nvim_create_user_command(cmd_name, function(opts)
    local cmd = vim_cmd .. (opts.bang and '!' or '')
    
    -- For non-bang quit commands, check for unsaved changes first
    if not opts.bang and vim_cmd:match('^q') and has_unsaved_changes() then
      -- Let Vim handle this naturally by just running the command
      -- It will show the proper E37 error
      vim.cmd(cmd)
      return
    end
    
    -- Only check shared session if the quit would succeed
    if is_shared_session() then
      local response = vim.fn.input '⚠️  Closing shared nvim session! Confirm with y/Y: '
      if response:lower() ~= 'y' then
        print '\nQuit cancelled'
        return
      end
    end
    
    -- Execute the command
    vim.cmd(cmd)
  end, { bang = true })
end

function M.setup()
  -- Only hook into explicit session-ending commands
  -- Don't override basic :q since that's often used to close windows
  
  -- Override only the "quit all" commands
  vim.cmd [[
    cabbrev qa <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Qa' : 'qa')<CR>
    cabbrev qall <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Qa' : 'qall')<CR>
  ]]
  
  create_quit_command('Qa', 'qa')
  
  -- Override ZZ (save and quit) - this always ends the session
  vim.keymap.set('n', 'ZZ', function()
    -- ZZ saves then quits, so just check session
    if is_shared_session() then
      local response = vim.fn.input '⚠️  ZZ will close shared nvim session! Confirm with y/Y: '
      if response:lower() ~= 'y' then
        print '\nQuit cancelled'
        return
      end
    end
    -- Execute normal ZZ behavior
    vim.cmd 'wq'
  end, { desc = 'Save and quit with shared session check' })

  -- Override ZQ (force quit) - this always ends the session
  vim.keymap.set('n', 'ZQ', function()
    if is_shared_session() then
      local response = vim.fn.input '⚠️  ZQ will close shared nvim session! Confirm with y/Y: '
      if response:lower() ~= 'y' then
        print '\nQuit cancelled'
        return
      end
    end
    -- Execute normal ZQ behavior
    vim.cmd 'q!'
  end, { desc = 'Quit without saving with shared session check' })
end

return M