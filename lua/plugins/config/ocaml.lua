-- OCaml configuration
-- Note: Indentation, comment strings, and other editor settings are handled by:
--   - vim-sleuth (automatic indentation detection)
--   - Comment.nvim (comment string detection)
--   - conform.nvim (formatting via ocamlformat)
-- This file only contains OCaml-specific keymaps and commands.

local M = {}

M.setup = function()
  -- Set up OCaml-specific keymaps
  local group = vim.api.nvim_create_augroup('OCamlKeymaps', { clear = true })

  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = { 'ocaml', 'ocaml.menhir', 'ocaml.interface', 'ocaml.ocamllex', 'reason', 'dune' },
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local opts = { buffer = bufnr, noremap = true, silent = true }

      -- Run dune build
      vim.keymap.set('n', '<leader>ob', ':!dune build<CR>', vim.tbl_extend('force', opts, { desc = 'OCaml: Dune build' }))

      -- Run dune test
      vim.keymap.set('n', '<leader>ot', ':!dune test<CR>', vim.tbl_extend('force', opts, { desc = 'OCaml: Dune test' }))

      -- Send to REPL (requires vim-slime)
      vim.keymap.set('v', '<leader>or', '<Plug>SlimeRegionSend', vim.tbl_extend('force', opts, { desc = 'OCaml: Send to REPL' }))
      vim.keymap.set('n', '<leader>or', '<Plug>SlimeParagraphSend', vim.tbl_extend('force', opts, { desc = 'OCaml: Send paragraph to REPL' }))

      -- Jane Street Core library documentation
      vim.keymap.set(
        'n',
        '<leader>od',
        ':!open https://ocaml.janestreet.com/ocaml-core/latest/doc/core/index.html<CR>',
        vim.tbl_extend('force', opts, { desc = 'OCaml: Open Core docs' })
      )
    end,
  })
end

return M
