vim.pack.add({
  {
    src = 'https://github.com/mrcjkb/rustaceanvim',
    version = vim.version.range('^9') }
})

vim.g.rustaceanvim = {
  tools = {
  },
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set({ "n", "v"}, "<leader>ca", function() vim.cmd.RustLsp('codeAction') end, { buffer = bufnr })
      vim.keymap.set("n", "K", function() vim.cmd.RustLsp({'hover', 'actions'}) end, { buffer = bufnr })
    end,
    default_settings = {
      ['rust-analyzer'] = {
      },
    },
  },
  dap = {
  },
}


