-- Blink.cmp Configuration
local M = {}

function M.setup()
  require('blink.cmp').setup {
    -- Keymap configuration
    keymap = {
      preset = 'default',
      ['<C-g>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<C-y>'] = { 'select_and_accept' },

      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      ['<M-n>'] = { 'snippet_forward', 'fallback' },
      ['<M-p>'] = { 'snippet_backward', 'fallback' },
    },

    -- Appearance configuration
    appearance = {
      -- use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
      kind_icons = {
        Copilot = '',
        Text = '',
        Method = 'ƒ',
        Function = 'ƒ',
        Constructor = '',
        Field = '',
        Variable = '',
        Property = '',
        Class = '',
        Interface = '',
        Struct = '',
        Module = '',
        Unit = '',
        Value = '',
        Enum = '',
        EnumMember = '',
        Keyword = '',
        Constant = '',
        Snippet = ' ',
        Color = '',
        File = '',
        Reference = '',
        Folder = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
      },
    },

    -- Sources configuration with Copilot integration
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
      providers = {
        copilot = {
          name = 'copilot',
          module = 'blink-cmp-copilot',
          score_offset = -5,
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = 'Copilot'
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
      },
    },

    -- Command line configuration (new API)
    cmdline = {
      enabled = true,
    },

    -- Signature help configuration
    signature = {
      enabled = true,
      window = {
        border = 'rounded',
      },
    },

    -- Completion configuration
    completion = {
      keyword = { range = 'full' },
      accept = {
        -- Auto-insert brackets for functions
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          columns = {
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind' },
          },
        },
        border = 'rounded',
        winblend = 0,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = 'rounded',
        },
      },
      ghost_text = {
        enabled = false, -- Disabled: was showing unwanted text on Tab
      },
    },

    -- Fuzzy matching configuration
    fuzzy = {
      -- Use Rust implementation for better performance
      implementation = 'prefer_rust_with_warning',
      -- Allow typos based on keyword length
      max_typos = function(keyword)
        return math.floor(#keyword / 4)
      end,
      -- Track frequently/recently used items
      use_frecency = true,
      -- Boost items matching nearby words
      use_proximity = true,
      -- Prebuilt binaries configuration
      prebuilt_binaries = {
        download = true,
      },
    },

    -- Snippet configuration
    snippets = {
      expand = function(snippet)
        -- Use native snippet expansion if available
        if vim.snippet then
          vim.snippet.expand(snippet)
        else
          -- Fallback to basic expansion
          local insert = string.gsub(snippet, '%$%d+', '')
          vim.api.nvim_put({ insert }, 'c', true, true)
        end
      end,
    },
  }
end

return M
