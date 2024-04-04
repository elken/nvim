--[[
Another _crucial_ plugin.

Treesitter itself is in short a way to create a grammar for some programming language (DSL or otherwise) and then consume that grammar through editor to get an AST of the document.

In short, instead of having to define "jump to the next function" for every language, you define it as part of the grammar then by writing queries you can generate "things" to navigate to/around/etc.

We can bootstrap all the grammars we're likely to use, as well as auto-install when we load a new file anyway, then the rest is just configuration.

Note that the playground has been upstreamed as `vim.treesitter.dev()`
--]]

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    if vim.g.started_by_firenvim then
      require("nvim-treesitter.install").prefer_git = true
    end

    -- Main treesitter config
    require("nvim-treesitter.configs").setup({
      ensure_installed = vim.g.started_by_firenvim and {} or {
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
        "markdown_inline",
        "passwd",
        "properties",
        "query",
        "regex",
        "ruby",
        "sql",
        "ssh_config",
        "tmux",
        "toml",
        "typescript",
        "typst",
        "vim",
        "vimdoc",
        "yaml",
      },
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
            ["ip"] = "@parameter.inner",
            ["ap"] = "@parameter.outer",
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
  end,
  dependencies = {
    "RRethy/nvim-treesitter-textsubjects", -- Location & syntax-aware text objects
    "nvim-treesitter/nvim-treesitter-textobjects", -- Custom objects using treesitter
    "JoosepAlviste/nvim-ts-context-commentstring", -- Correctly guess which comment to  in a mixed-mode file
  },
}
