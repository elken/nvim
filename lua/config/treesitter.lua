local M = {}

function M.setup()
  -- Prefer git for downloading parsers
  if vim.g.started_by_firenvim then
    require("nvim-treesitter.install").prefer_git = true
  end

  -- Main treesitter config
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "c",
      "clojure",
      "commonlisp",
      "css",
      "diff",
      "dockerfile",
      "dot",
      "eex",
      "elixir",
      "fennel",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "graphql",
      "heex",
      "html",
      "http",
      "javascript",
      "json",
      "jsonc",
      "just",
      "lua",
      "luadoc",
      "markdown",
      "org",
      "passwd",
      "properties",
      "query",
      "regex",
      "ruby",
      "sql",
      "ssh_config",
      "swift",
      "tmux",
      "toml",
      "typescript",
      "typst",
      "vim",
      "vimdoc",
      "yaml",
    },
    additional_vim_regex_highlighting = { "org" },
    auto_install = not vim.g.started_by_firenvim,

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
        lookahead = true,
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
          ["]f"] = "@function.outer",
          ["]p"] = "@parameter.outer",
          ["]c"] = "@call.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]P"] = "@parameter.outer",
          ["]C"] = "@call.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[p"] = "@parameter.outer",
          ["[c"] = "@call.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[P"] = "@parameter.outer",
          ["[C"] = "@call.outer",
        },
      },
    },
  })
end

return M
