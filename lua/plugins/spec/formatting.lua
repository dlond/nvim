-- Formatter configuration

return {
  -- ========================================
  -- Formatter Configuration (conform.nvim)
  -- ========================================
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre', -- Format on save
    -- cmd = { 'ConformInfo' }, -- Optional: If you want the command available
    -- keys = { ... } -- Optional: Define keys if needed
    opts = {
      formatters_by_ft = {
        -- Core languages
        lua = { 'stylua' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        python = { 'ruff_organize_imports', 'ruff_format', 'ruff_fix' },
        nix = { 'alejandra' },
        ocaml = { 'ocamlformat' },

        -- Shell scripts
        bash = { 'shfmt' },
        sh = { 'shfmt' },

        -- Build/config files
        cmake = { 'cmake_format' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
      },
      -- Custom formatter configurations
      formatters = {
        ocamlformat = {
          prepend_args = { '--enable-outside-detected-project' },
        },
      },
      -- Configure format_on_save behavior
      format_on_save = {
        timeout_ms = 2000, -- Increased for ocamlformat (can be slow)
        lsp_fallback = true, -- Use LSP formatting if conform formatter unavailable
      },
    },
  },
}
