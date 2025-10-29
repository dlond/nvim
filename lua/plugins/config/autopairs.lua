-- Auto-pairs - Automatically close brackets, quotes, etc.
local M = {}

function M.setup()
  pcall(function()
    require('vim._extui').enable {}
  end)

  require('blink.pairs').setup {
    mappings = {
      enabled = true,
      cmdline = true,
      disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
    },
    highlights = {
      enabled = true,
      cmdline = true,
      groups = {
        'BlinkPairsOrange',
        'BlinkPairsPurple',
        'BlinkPairsBlue',
      },
      unmatched_group = 'BlinkPairsUnmatched',

      -- highlights matching pairs under the cursor
      matchparen = {
        enabled = true,
        -- known issue where typing won't update matchparen highlight, disabled by default
        cmdline = false,
        -- also include pairs not on top of the cursor, but surrounding the cursor
        include_surrounding = false,
        group = 'BlinkPairsMatchParen',
        priority = 250,
      },
    },
    debug = false,
  }

  -- UNIFIED KEY TO KILL AUTO-INSERTED STUFF
  -- <C-u> already kills auto-inserted comments (built-in)
  -- Let's add <C-u> to also kill auto-paired character

  vim.keymap.set('i', '<C-u>', function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col '.' - 1

    -- Check if we're at the beginning of a line with just comment chars
    local comment_pattern = '^%s*[#%-/]+%s*$'
    if line:sub(1, col):match(comment_pattern) then
      -- Kill the whole comment prefix (default <C-u> behavior)
      return '<C-u>'
      -- Check if cursor is between paired characters
    elseif col > 0 and col < #line then
      local before = line:sub(col, col)
      local after = line:sub(col + 1, col + 1)
      local pairs = { ['('] = ')', ['['] = ']', ['{'] = '}', ['"'] = '"', ["'"] = "'" }
      if pairs[before] == after then
        -- Delete the closing pair
        return '<Del>'
      end
    end
    -- Otherwise, regular <C-u> (kill to start of line)
    return '<C-u>'
  end, { expr = true, desc = 'Kill auto-insert or line to start' })
end

return M
