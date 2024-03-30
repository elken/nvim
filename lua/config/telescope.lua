local M = {}

function M.setup()
  require("telescope").setup({
    extensions = {
      file_browser = {
        theme = "ivy",
        hijack_netrw = true,
      },
      frecency = {
        db_safe_mode = false,
      },
    },
  })

  require("project_nvim").setup({})
  require("neoclip").setup({
    enable_persistent_history = true,
  })
  require("telescope").load_extension("projects")
  require("telescope").load_extension("neoclip")
  if not vim.g.started_by_firenvim then
    require("telescope").load_extension("frecency")
  end
  require("telescope").load_extension("file_browser")
  require("telescope").load_extension("ui-select")
end

return M
