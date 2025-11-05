local M = {}

function M.setup()
  local lint = require 'lint'

  lint.linters_by_ft = {
    cpp = { 'clangtidy' },
    python = { 'ruff' },
    bash = { 'shellcheck' },
    nix = { 'statix' },
  }

  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    callback = function()
      lint.try_lint()
    end,
  })
end

return M
