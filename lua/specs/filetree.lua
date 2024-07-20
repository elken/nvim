local git_ignored = setmetatable({}, {
  __index = function(self, key)
    local proc = vim.system({ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" }, {
      cwd = key,
      text = true,
    })
    local result = proc:wait()
    local ret = {}
    if result.code == 0 then
      for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
        -- Remove trailing slash
        line = line:gsub("/$", "")
        table.insert(ret, line)
      end
    end

    rawset(self, key, ret)
    return ret
  end,
})

return {
  {
    "stevearc/oil.nvim",
    opts = {
      delete_to_trash = true,
      watch_for_changes = true,
      view_options = {
        is_hidden_file = function(name, _)
          local dir = require("oil").get_current_dir()
          -- if no local directory (e.g. for ssh connections), always show
          if not dir then
            return false
          end
          -- Check if file is gitignored
          return vim.list_contains(git_ignored[dir], name)
        end,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
          "saifulapm/neotree-file-nesting-config",
        },
        config = function()
          require("neo-tree").setup({
            nesting_rules = require("neotree-file-nesting-config").nesting_rules,
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
              hijack_netrw_behavior = "disabled",
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
            use_libuv_file_watcher = true,
          })
        end,
      },
    },
    opts = {},
  },
}
