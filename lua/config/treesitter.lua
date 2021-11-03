local M = {}

function M.setup()
  if vim.fn.has("mac") == 1 then
    require("nvim-treesitter.install").compilers = { "gcc-11" }
  end

  -- Extra parser configs
  local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
  parser_configs.haskell = {
    install_info = {
      url = "https://github.com/tree-sitter/tree-sitter-haskell",
      files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "haskell",
  }
  parser_configs.markdown = {
    install_info = {
      url = "https://github.com/ikatyang/tree-sitter-markdown",
      files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "markdown",
  }

  parser_configs.org = {
    install_info = {
      url = "https://github.com/milisims/tree-sitter-org",
      revision = "main",
      files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "org",
  }

  -- Main treesitter config
  require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    additional_vim_regex_highlighting = { "org" },

    highlight = {
      enable = true,
    },

    incremental_selection = {
      enable = true,

      keymaps = {
        init_selection = "gnn",
        node_incremental = "gnn",
        scope_incremental = "gns",
        node_decremental = "gnp",
      },
    },

    indent = { enable = true },

    textsubjects = {
      enable = true,
      keymaps = { [","] = "textsubjects-smart" },
    },

    autopairs = { enable = true },

    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["icd"] = "@conditional.inner",
          ["acd"] = "@conditional.outer",
          ["acm"] = "@comment.outer",
          ["ilp"] = "@loop.inner",
          ["alp"] = "@loop.outer",
          ["ast"] = "@statement.outer",
          ["isc"] = "@scopename.inner",
          ["iB"] = "@block.inner",
          ["aB"] = "@block.outer",
          ["p"] = "@parameter.inner",
        },
      },

      move = {
        enable = true,
        set_jumps = true, -- Whether to set jumps in the jumplist
        goto_next_start = {
          ["gnf"] = "@function.outer",
          ["gnif"] = "@function.inner",
          ["gnp"] = "@parameter.inner",
          ["gnc"] = "@call.outer",
          ["gnic"] = "@call.inner",
        },
        goto_next_end = {
          ["gnF"] = "@function.outer",
          ["gniF"] = "@function.inner",
          ["gnP"] = "@parameter.inner",
          ["gnC"] = "@call.outer",
          ["gniC"] = "@call.inner",
        },
        goto_previous_start = {
          ["gpf"] = "@function.outer",
          ["gpif"] = "@function.inner",
          ["gpp"] = "@parameter.inner",
          ["gpc"] = "@call.outer",
          ["gpic"] = "@call.inner",
        },
        goto_previous_end = {
          ["gpF"] = "@function.outer",
          ["gpiF"] = "@function.inner",
          ["gpP"] = "@parameter.inner",
          ["gpC"] = "@call.outer",
          ["gpiC"] = "@call.inner",
        },
      },
    },

    playground = {
      enable = true,
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },

    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 1000,
      colors = {
        "#bf616a",
        "#d08770",
        "#ebcb8b",
        "#a3be8c",
        "#88c0d0",
        "#5e81ac",
        "#b48ead",
      },
    },
    context_commentstring = { enable = true },

    refactor = {
      highlight_definitions = { enable = true },
    },
  })
end

return M
