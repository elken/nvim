return {
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "saifulapm/neotree-file-nesting-config",
    },
    opts = {
      window = {
        mappings = {
          ["T"] = "trash",
          ["<s-Tab>"] = "prev_source",
          ["<Tab>"] = "next_source",
        },
      },
      commands = {
        trash = function(state)
          local node = state.tree:get_node()
          if node.type == "message" then
            return
          end
          local _, name = require("neo-tree.utils").split_path(node.path)
          local msg = string.format("Are you sure you want to trash '%s'?", name)
          require("neo-tree.ui.inputs").confirm(msg, function(confirmed)
            if not confirmed then
              return
            end
            vim.api.nvim_command("silent !trash -F " .. node.path)
            require("neo-tree.sources.manager").refresh(state)
          end)
        end,
        trash_visual = function(state, selected_nodes)
          local paths_to_trash = {}
          for _, node in ipairs(selected_nodes) do
            if node.type ~= "message" then
              table.insert(paths_to_trash, node.path)
            end
          end
          local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
          require("neo-tree.ui.inputs").confirm(msg, function(confirmed)
            if not confirmed then
              return
            end
            for _, path in ipairs(paths_to_trash) do
              vim.api.nvim_command("silent !trash -F " .. path)
            end
            require("neo-tree.sources.manager").refresh(state)
          end)
        end,
      },
      filesystem = {
        filtered_items = {
          show_hidden_count = false,
          hide_dotfiles = false,
          hide_hidden = false,
          hide_by_name = {
            "node_modules",
            ".git",
            "vendor",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
        follow_current_file = {
          enabled = true,
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
        },
      },
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      source_selector = {
        winbar = true,
        sources = {
          { source = "filesystem" },
          { source = "buffers" },
          { source = "remote" },
          { source = "document_symbols" },
        },
      },
      hide_root_node = true,
      retain_hidden_root_indent = true,
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
    config = function(_, opts)
      -- Adding rules from plugin
      opts.nesting_rules = require("neotree-file-nesting-config").nesting_rules
      require("neo-tree").setup(opts)
    end,
  },
}
