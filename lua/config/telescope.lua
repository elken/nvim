local M = {}

function M.setup()
  local actions = require("telescope.actions")
  require("telescope").setup({
    extensions = {
      file_browser = {
        hijack_netrw = true,
      },
    },
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
        },
      },
    },
  })
  require("project_nvim").setup({})
  require("neoclip").setup({
    enable_persistent_history = true,
  })
  require("telescope").load_extension("projects")
  require("telescope").load_extension("neoclip")
  require("telescope").load_extension("frecency")
  require("telescope").load_extension("file_browser")
end

return M
