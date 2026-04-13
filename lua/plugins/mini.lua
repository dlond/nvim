vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.nvim",
    version = "main",
  },
})

local mini_config = require("plugins.config.mini")

require("mini.extra").setup()

-- Text editing
require("mini.ai").setup()
require("mini.move").setup()
require("mini.operators").setup()
require("mini.surround").setup()

-- General workflow
require("mini.basics").setup()
require("mini.bracketed").setup()
require("mini.pick").setup()
vim.keymap.set("n", "<Leader>sf", [[<Cmd>Pick files<CR>]], { desc = "Files" })
vim.keymap.set("n", "<Leader>sb", [[<Cmd>Pick buffers<CR>]], { desc = "Buffers" })
vim.keymap.set("n", "<Leader>sg", [[<Cmd>Pick grep_live<CR>]], { desc = "Grep Live" })
vim.keymap.set("n", "<Leader>sh", [[<Cmd>Pick help<CR>]], { desc = "Help" })
vim.keymap.set("n", "<Leader>sk", [[<Cmd>Pick keymaps<CR>]], { desc = "Keymaps" })
vim.keymap.set("n", "<Leader>so", [[<Cmd>Pick options<CR>]], { desc = "Options" })
vim.keymap.set("n", "<Leader>sr", [[<Cmd>Pick resume<CR>]], { desc = "Resume" })

local miniclue = require("mini.clue")
miniclue.setup({
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
    { mode = "n", keys = "<leader>d", desc = "+Debug" },
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
})

require("mini.diff").setup()
require("mini.git").setup()

-- Appearance
require("mini.icons").setup()
local ministatusline = require("mini.statusline")
ministatusline.setup({
    content = {
    active = function()
      local mode, mode_hl = ministatusline.section_mode({ trunc_width = 120 })
      local git           = ministatusline.section_git({ trunc_width = 40 })
      local diagnostics   = ministatusline.section_diagnostics({ trunc_width = 75 })
      local lsp           = ministatusline.section_lsp({ trunc_width = 75 })
      local filename      = ministatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = ministatusline.section_fileinfo({ trunc_width = 120 })
      local location      = ministatusline.section_location({ trunc_width = math.huge,  })
      local search        = ministatusline.section_searchcount({ trunc_width = 75 })

      return ministatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
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
})
