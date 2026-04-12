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
    { mode = "n", keys = "<Leader>s", desc = "+Search" },
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

return M
