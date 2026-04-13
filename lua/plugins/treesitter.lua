vim.pack.add({
  {
    src="https://github.com/nvim-treesitter/nvim-treesitter",
    version="main"
  }
})

vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Handle nvim-tresitter updates",
  group = vim.api.nvim_create_augroup("nvim-tresitter-pack-changed", { clear = true }),
  callback = function(ev)
    if ev.data.kind == "update" and ev.data.spec.name == "nvim-treesitter" then
      vim.notify("nvim-treesitter updated, running TSUpdate", vim.log.levels.INFO)
      local ok = pcall(vim.cmd, "TSUpdate")
      if ok then
        vim.notify("TSUpdate completed successfully", vim.log.levels.INFO)
      else
        vim.notify("TSUpdate failed, skipping", vim.log.levels.WARN)
      end
    end
  end,
})
