-- Generic code runner with pluggable backends.
-- Each backend implements: setup(), configure(), build(), run(), test(), status(), reset()
-- Dependencies are chained automatically: run → build → configure → setup

local float_term = require('core.float_term')

local M = {}

local backends = {}
local active_backend = nil

function M.register(name, backend)
  backends[name] = backend
  backend.name = name
  backend.term = float_term
end

local function detect_backend()
  if active_backend then return active_backend end

  -- Auto-detect from project files
  if vim.fn.filereadable('CMakeLists.txt') == 1 then
    active_backend = backends['cpp']
  elseif vim.fn.filereadable('pyproject.toml') == 1
    or vim.fn.filereadable('setup.py') == 1
    or vim.fn.filereadable('requirements.txt') == 1 then
    active_backend = backends['python']
  end

  return active_backend
end

local function with_backend(callback)
  local b = detect_backend()
  if b then return callback(b) end

  local names = vim.tbl_keys(backends)
  if #names == 0 then
    vim.notify('No code backends registered', vim.log.levels.WARN)
    return
  end

  vim.ui.select(names, { prompt = 'Project type:' }, function(choice)
    if not choice then return end
    active_backend = backends[choice]
    callback(active_backend)
  end)
end

-- Pipeline: each step ensures its dependencies
local function ensure_setup(b, callback)
  if not b.setup then return callback() end
  b.setup(callback)
end

local function ensure_configure(b, callback)
  ensure_setup(b, function()
    if not b.configure then return callback() end
    b.configure(callback)
  end)
end

local function ensure_build(b, target, callback)
  ensure_configure(b, function()
    if not b.build then return callback() end
    b.build(target, callback)
  end)
end

function M.configure()
  with_backend(function(b)
    ensure_configure(b, function() end)
  end)
end

function M.build(target)
  with_backend(function(b)
    ensure_build(b, target, function() end)
  end)
end

function M.run()
  with_backend(function(b)
    if not b.run then
      vim.notify(b.name .. ': run not implemented', vim.log.levels.WARN)
      return
    end
    b.run()
  end)
end

function M.test()
  with_backend(function(b)
    if not b.test then
      vim.notify(b.name .. ': test not implemented', vim.log.levels.WARN)
      return
    end
    b.test()
  end)
end

function M.go()
  with_backend(function(b)
    if not b.go then
      vim.notify(b.name .. ': interactive mode not implemented', vim.log.levels.WARN)
      return
    end
    b.go()
  end)
end

function M.status()
  with_backend(function(b)
    if b.status then b.status() end
  end)
end

function M.reset()
  if active_backend and active_backend.reset then
    active_backend.reset()
  end
  active_backend = nil
  vim.notify('Code runner reset', vim.log.levels.INFO)
end

return M
