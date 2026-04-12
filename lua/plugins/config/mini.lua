local M = {}

local miniclue = require("mini.clue")

vim.keymap.set("n", "<Leader>sf", [[<Cmd>Pick files<CR>]], { desc = "Files" })
vim.keymap.set("n", "<Leader>sb", [[<Cmd>Pick buffers<CR>]], { desc = "Buffers" })
vim.keymap.set("n", "<Leader>sg", [[<Cmd>Pick grep_live<CR>]], { desc = "Grep Live" })
vim.keymap.set("n", "<Leader>sh", [[<Cmd>Pick help<CR>]], { desc = "Help" })
vim.keymap.set("n", "<Leader>sk", [[<Cmd>Pick keymaps<CR>]], { desc = "Keymaps" })
vim.keymap.set("n", "<Leader>sr", [[<Cmd>Pick resume<CR>]], { desc = "Resume" })

M["clue"] = {
  triggers = {
    -- Leader triggers
    { mode = { "n", "x" }, keys = "<Leader>" },

    -- `[` and `]` keys
    { mode = "n", keys = "[" },
    { mode = "n", keys = "]" },

    -- Built-in completion
    { mode = "i", keys = "<C-x>" },

    -- `g` key
    { mode = { "n", "x" }, keys = "g" },

    -- Marks
    { mode = { "n", "x" }, keys = "'" },
    { mode = { "n", "x" }, keys = "`" },

    -- Registers
    { mode = { "n", "x" }, keys = '"' },
    { mode = { "i", "c" }, keys = "<C-r>" },

    -- Window commands
    { mode = "n", keys = "<C-w>" },

    -- `z` key
    { mode = { "n", "x" }, keys = "z" },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    { mode = "n", keys = "<leader>l", desc = "+LSP" },
    { mode = "n", keys = "<leader>s", desc = "+Search" },

    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
  window = {
    delay = 0,
    config = {
      anchor = "SE",
      width = "auto",
      row = "auto",
      col = "auto",
    },
    scroll_down = "<C-n>",
    scroll_up = "<C-p",
  },
}

M["statusline"] = {
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git           = MiniStatusline.section_git({ trunc_width = 40 })
      -- local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location      = MiniStatusline.section_location({ trunc_width = math.huge,  })
      local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        -- { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
        { hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics, lsp } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { search, location } },
      })
    end,

    inactive = nil,
  },
  use_icons = true,
}

return M
