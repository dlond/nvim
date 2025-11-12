-- Bootstrap lazy.nvim
require 'core.bootstrap'

-- Core settings (must be before plugins)
require 'core.options'
require 'core.keymaps'
require 'core.autocmds'
require('core.shared-session').setup()

vim.env.DEVELOPER_DIR = '/Applications/Xcode.app/Contents/Developer'

-- Load plugins via lazy.nvim
require('lazy').setup('plugins.spec', {
  change_detection = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
