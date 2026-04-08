-- Python backend for core.code
-- Projects use uv with venv already activated via nix flake

local code = require('core.code')

local M = {}

local state = {
  synced = false,
}

function M.status()
  local synced = state.synced and 'ok' or 'pending'
  vim.notify(string.format('Python [uv] sync=%s', synced), vim.log.levels.INFO)
end

function M.reset()
  state.synced = false
  vim.notify('Python state reset', vim.log.levels.INFO)
end

function M.configure(callback)
  if state.synced then return callback() end
  M.term.open('uv sync')
  state.synced = true
  callback()
end

function M.run()
  M.configure(function()
    local file = vim.fn.expand('%:p')
    if file:match('%.py$') then
      M.term.open('uv run python ' .. file)
    else
      vim.ui.input({ prompt = 'Python file: ', default = 'main.py' }, function(input)
        if input and input ~= '' then
          M.term.open('uv run python ' .. input)
        end
      end)
    end
  end)
end

function M.test()
  M.configure(function()
    M.term.open('uv run pytest')
  end)
end

function M.go()
  vim.ui.select({ 'run current file', 'run main.py', 'test', 'sync' }, { prompt = 'Python:' }, function(choice)
    if not choice then return end
    if choice == 'run current file' then
      M.run()
    elseif choice == 'run main.py' then
      M.configure(function()
        M.term.open('uv run python main.py')
      end)
    elseif choice == 'test' then
      M.test()
    elseif choice == 'sync' then
      state.synced = false
      M.configure(function() end)
    end
  end)
end

code.register('python', M)

return M
