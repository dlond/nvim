-- Load Nix-controlled settings if available
pcall(require, "nix-settings")

vim.g.python3_host_prog = "/Users/dlond/.local/share/python/base/.venv/bin/python"
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Set based on your font installation
vim.g.have_nerd_font = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Mouse and interaction
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.showmode = false -- Don't show mode since we have a statusline

-- Clipboard - sync with system clipboard
vim.opt.clipboard = "unnamedplus"

-- Indentation settings
-- vim.opt.breakindent = true -- Enable break indent
-- vim.opt.smartindent = true
-- vim.opt.autoindent = true

-- Tabstops
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Save undo history
vim.opt.undofile = true

-- Search settings
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.smartcase = true -- Unless capital in search

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Set the default boarder for all floating windows
vim.opt.winborder = "rounded"

vim.opt.complete = "o,.,w,b,u"
vim.opt.completeopt = "menu,menuone,noinsert,fuzzy,popup"
