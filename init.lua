-- Bootstrap lazy.nvim
require 'core.bootstrap'

require 'core.global'
-- Core settings (must be before plugins)
require 'core.options'
require 'core.keymaps'
require 'core.autocmds'
require 'core.lsp'

vim.env.DEVELOPER_DIR = '/Applications/Xcode.app/Contents/Developer'

-- Load plugins via lazy.nvim
require('lazy').setup('plugins.spec', {
  change_detection = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'blink.cmp',
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
