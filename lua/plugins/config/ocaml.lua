-- OCaml configuration for Jane Street development
local M = {}

M.setup = function()
  -- Set up OCaml-specific keymaps
  local group = vim.api.nvim_create_augroup('OCamlKeymaps', { clear = true })
  
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = { 'ocaml', 'dune' },
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local opts = { buffer = bufnr, noremap = true, silent = true }
      
      -- Type hints
      vim.keymap.set('n', '<leader>ot', ':lua vim.lsp.buf.hover()<CR>', 
        vim.tbl_extend('force', opts, { desc = 'OCaml: Show type' }))
      
      -- Switch between .ml and .mli files
      vim.keymap.set('n', '<leader>oi', ':lua require("plugins.config.ocaml").switch_impl_intf()<CR>',
        vim.tbl_extend('force', opts, { desc = 'OCaml: Switch .ml/.mli' }))
      
      -- Format with ocamlformat
      vim.keymap.set('n', '<leader>of', ':lua vim.lsp.buf.format({ async = true })<CR>',
        vim.tbl_extend('force', opts, { desc = 'OCaml: Format' }))
      
      -- Run dune build
      vim.keymap.set('n', '<leader>ob', ':!dune build<CR>',
        vim.tbl_extend('force', opts, { desc = 'OCaml: Dune build' }))
      
      -- Run dune test
      vim.keymap.set('n', '<leader>oT', ':!dune test<CR>',
        vim.tbl_extend('force', opts, { desc = 'OCaml: Dune test' }))
      
      -- Send to REPL (requires vim-slime)
      vim.keymap.set('v', '<leader>or', '<Plug>SlimeRegionSend',
        vim.tbl_extend('force', opts, { desc = 'OCaml: Send to REPL' }))
      vim.keymap.set('n', '<leader>or', '<Plug>SlimeParagraphSend',
        vim.tbl_extend('force', opts, { desc = 'OCaml: Send paragraph to REPL' }))
        
      -- Jane Street Core library documentation
      vim.keymap.set('n', '<leader>od', ':!open https://ocaml.janestreet.com/ocaml-core/latest/doc/core/index.html<CR>',
        vim.tbl_extend('force', opts, { desc = 'OCaml: Open Core docs' }))
    end,
  })
  
  -- Call setup_autocmds
  M.setup_autocmds()
end

-- Switch between implementation and interface files
M.switch_impl_intf = function()
  local file = vim.fn.expand('%:p')
  local alt_file
  
  if file:match('%.ml$') then
    alt_file = file:gsub('%.ml$', '.mli')
  elseif file:match('%.mli$') then
    alt_file = file:gsub('%.mli$', '.ml')
  else
    vim.notify('Not an OCaml file', vim.log.levels.WARN)
    return
  end
  
  if vim.fn.filereadable(alt_file) == 1 then
    vim.cmd('edit ' .. alt_file)
  else
    vim.notify('File not found: ' .. alt_file, vim.log.levels.WARN)
  end
end

-- Auto commands for OCaml
M.setup_autocmds = function()
  local group = vim.api.nvim_create_augroup('OCamlSettings', { clear = true })
  
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = { 'ocaml', 'dune' },
    callback = function()
      -- Set indent to 2 spaces (OCaml convention)
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.expandtab = true
      
      -- Enable comment continuation
      vim.bo.comments = 's0:(*,mb:*,ex:*),:;;'
      vim.bo.commentstring = '(* %s *)'
      
      -- Set up folding for OCaml
      vim.wo.foldmethod = 'indent'
      vim.wo.foldlevel = 99
    end,
  })
  
  -- Auto-format on save (optional, comment out if you prefer manual)
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    pattern = '*.ml,*.mli',
    callback = function()
      -- Only format if ocamlformat config exists
      if vim.fn.filereadable('.ocamlformat') == 1 then
        vim.lsp.buf.format({ async = false })
      end
    end,
  })
end

-- Initialize autocmds
M.setup_autocmds()

return M