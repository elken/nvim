local M = {}

function M.setup()
  local actions = require("telescope.actions")
  require("telescope").setup({
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
    enable_persistant_history = true,
  })
  require("telescope").load_extension("projects")
  require("telescope").load_extension("neoclip")
  require("telescope").load_extension("frecency")
end

return M
