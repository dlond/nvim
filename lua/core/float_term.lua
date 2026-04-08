local M = {}

local buf = nil
local win = nil
local chan = nil

function M.open(cmd)
  -- Toggle off if already visible and no command to send
  if win and vim.api.nvim_win_is_valid(win) then
    if not cmd then
      vim.api.nvim_win_hide(win)
      return
    end
  end

  -- Create buffer if needed
  if not buf or not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true)
    chan = nil
  end

  -- Open window if needed
  if not win or not vim.api.nvim_win_is_valid(win) then
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    win = vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      width = width,
      height = height,
      col = math.floor((vim.o.columns - width) / 2),
      row = math.floor((vim.o.lines - height) / 2),
      style = 'minimal',
      border = 'rounded',
    })
  end

  -- Start terminal if needed
  if not chan then
    vim.cmd.terminal()
    chan = vim.bo[buf].channel
  end

  -- Send command if provided
  if cmd then
    vim.api.nvim_chan_send(chan, cmd .. '\n')
  end

  vim.cmd.startinsert()
end

function M.send(cmd)
  if chan then
    M.open(cmd)
  end
end

function M.reset()
  if buf and vim.api.nvim_buf_is_valid(buf) then
    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_hide(win)
    end
    vim.api.nvim_buf_delete(buf, { force = true })
  end
  buf = nil
  win = nil
  chan = nil
end

return M
