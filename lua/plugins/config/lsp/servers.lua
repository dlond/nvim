-- LSP Server Configurations
local M = {}

function M.get_servers()
  -- Build clangd command

  return {
    -- C/C++ Language Server
    clangd = {
      cmd = {
        'clangd',
        '--background-index',
        '--completion-style=detailed',
        '--enable-config',
        '--fallback-style=llvm',
        '--function-arg-placeholders=1',
        '--header-insertion-decorators',
        '--header-insertion=iwyu',
        '--pch-storage=memory',
      },
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
      -- Look for project markers - clangd will find compile_commands.json itself
      root_markers = { '.clangd', 'compile_commands.json', 'CMakeLists.txt', '.git' },
      single_file_support = true,
    },

    -- Python Language Server
    basedpyright = {
      settings = {
        basedpyright = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'openFilesOnly',
            typeCheckingMode = 'basic',
            useLibraryCodeForTypes = true,
            autoImportCompletions = true,

            -- Help with type hints
            inlayHints = {
              variableTypes = true,
              functionReturnTypes = true,
              parameterTypes = true,
            },

            diagnosticSeverityOverrides = {
              reportOptionalCall = 'none',
              reportOptionalSubscript = 'none',
              reportOptionalMemberAccess = 'none',
              reportOptionalIterable = 'none',
              reportAttributeAccessIssue = 'none',
              reportUnknownMemberType = 'none', -- Changed to none for less noise
              reportUnknownVariableType = 'none', -- Changed to none
              reportUnknownArgumentType = 'none', -- Added
              reportGeneralTypeIssues = 'none', -- Added
              reportUnknownParameterType = 'none', -- Added
              reportUnknownAssignmentType = 'none', -- From main
              reportMissingTypeStubs = 'none', -- From main
            },
          },
        },
        python = {
          analysis = {
            autoImportCompletions = true,
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    },

    -- Python Linter/Formatter
    ruff = {},

    -- Nix Language Server
    nixd = {},

    -- LaTeX Language Server
    texlab = {},

    -- CMake Language Server
    cmake = {
      cmd = { 'cmake-language-server' },
      filetypes = { 'cmake' },
      root_markers = { 'compile_commands.json', 'CMakeLists.txt', '.git' },
    },

    -- Lua Language Server
    lua_ls = {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = {
            globals = { 'vim' },
            unusedLocalExclude = { '_*' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    },

    -- Bash Language Server
    bashls = {},

    -- YAML Language Server
    yamlls = {},

    -- JSON Language Server
    jsonls = {},

    -- Markdown Language Server (Rust-based, avoids .NET build issues)
    markdown_oxide = {},

    -- TOML Language Server
    taplo = {},

    -- SQL Language Server
    sqls = {},

    -- OCaml Language Server
    ocamllsp = {
      filetypes = { 'ocaml', 'ocaml.menhir', 'ocaml.interface', 'ocaml.ocamllex', 'reason', 'dune' },
      root_markers = { '*.opam', 'esy.json', 'package.json', '.git', 'dune-project', 'dune-workspace' },
      cmd_env = {
        PATH = vim.env.PATH, -- Inherit PATH from Neovim's environment
      },
      settings = {
        ocaml = {
          lens = {
            enable = true,
          },
          inlayHints = {
            enable = true,
          },
        },
      },
    },

    -- Add more servers here as needed
    -- Example:
    -- rust_analyzer = {
    --   settings = {
    --     ['rust-analyzer'] = {
    --       checkOnSave = {
    --         command = 'clippy',
    --       },
    --     },
    --   },
    -- },
  }
end

return M
