---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".stylua.toml", ".git" },
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      codeLens = { enable = true },
      hint = { enable = true, semicolon = "Disable" },
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      telemetry = { enable = false },
    },
  },
}
