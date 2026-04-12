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
require("mini.bracketed").setup()
require("mini.pick").setup()
require("mini.clue").setup(mini_config["clue"])

-- Appearance
require("mini.icons").setup()
require("mini.statusline").setup()
