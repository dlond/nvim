local M = {}

function M.setup_blink()
  local ok, blink = pcall(require, 'blink.cmp')
  if not ok then
    return
  end

  local opts = blink.config or {}
  opts.sources = opts.sources or {}

  local default_sources = opts.sources.default or { 'lsp', 'path', 'buffer', 'snippets' }

  if vim.g.use_copilot then
    local seen = {}
    local new = { 'copilot' }
    for _, name in ipairs(default_sources) do
      if name ~= 'copilot' and not seen[name] then
        table.insert(new, name)
        seen[name] = true
      end
    end
    default_sources = new
  else
    local new = {}
    for _, name in ipairs(default_sources) do
      if name ~= 'copilot' then
        table.insert(new, name)
      end
    end
    default_sources = new
  end

  opts.sources.default = default_sources
  blink.setup(opts)
end

function M.setup_copilot()
  require('copilot').setup {
    suggestion = { enabled = false },
    panel = { enabled = false },
  }
end

function M.setup_blink_copilot()
  local ok, src = pcall(require, 'blink-cmp-copilot')
  if ok and src.setup then
    src.setup {}
  end
end

return M
