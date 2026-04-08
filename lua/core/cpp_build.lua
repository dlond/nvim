-- C++ backend for core.code
-- Delegates to cmake-tools.nvim and nvim-conan for the heavy lifting

local code = require('core.code')

local M = {}

local state = {
  conan = false,
}

function M.status()
  local conan = state.conan and 'ok' or 'pending'
  -- cmake-tools tracks its own state (preset, build type, target)
  vim.notify(string.format('C++ conan=%s (use :CMakeSettings for cmake state)', conan), vim.log.levels.INFO)
end

function M.reset()
  state.conan = false
  vim.notify('C++ conan state reset (use :CMakeSelectConfigurePreset to reconfigure)', vim.log.levels.INFO)
end

function M.setup(callback)
  -- cmake-tools handles preset selection via :CMakeSelectConfigurePreset
  -- just ensure conan has been run
  if state.conan then return callback() end
  vim.ui.select({ 'Yes', 'No' }, { prompt = 'Run conan install first?' }, function(choice)
    if choice == 'Yes' then
      vim.cmd('Conan install')
      state.conan = true
    end
    callback()
  end)
end

function M.configure(callback)
  M.setup(function()
    vim.cmd('CMakeGenerate')
    callback()
  end)
end

function M.build(target, callback)
  if target then
    vim.cmd('CMakeBuild --target ' .. target)
  else
    vim.cmd('CMakeBuild')
  end
  if callback then callback() end
end

function M.run()
  vim.cmd('CMakeRun')
end

function M.test()
  vim.cmd('CTest')
end

function M.go()
  M.setup(function()
    vim.ui.select({ 'configure', 'build', 'run', 'test', 'select preset', 'select target' }, {
      prompt = 'C++:',
    }, function(choice)
      if not choice then return end
      if choice == 'configure' then
        vim.cmd('CMakeGenerate')
      elseif choice == 'build' then
        vim.cmd('CMakeBuild')
      elseif choice == 'run' then
        vim.cmd('CMakeRun')
      elseif choice == 'test' then
        vim.cmd('CTest')
      elseif choice == 'select preset' then
        vim.cmd('CMakeSelectConfigurePreset')
      elseif choice == 'select target' then
        vim.cmd('CMakeSelectLaunchTarget')
      end
    end)
  end)
end

code.register('cpp', M)

return M
