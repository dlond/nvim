-- OCaml development environment for Jane Street prep
local ocaml_files = { 'ocaml', 'ocaml.menhir', 'ocaml.interface', 'ocaml.ocamllex', 'reason', 'dune' }

return {
  -- OCaml syntax highlighting and indentation
  {
    'ocaml/vim-ocaml',
    lazy = false,  -- Load immediately for filetype detection
    priority = 1000,  -- Load very early
    config = function()
      require('plugins.config.ocaml').setup()
    end,
  },

  -- Interactive development (REPL integration with tmux)
  {
    'jpalardy/vim-slime',
    ft = ocaml_files,
    config = function()
      vim.g.slime_target = 'tmux'
      vim.g.slime_default_config = { socket_name = 'default', target_pane = '{last}' }
      vim.g.slime_dont_ask_default = 1
    end,
  },
}
