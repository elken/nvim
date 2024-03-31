local M = {}

function M.setup()
  require("telescope").setup({
    defaults = {
      winblend = 70,
    },
    extensions = {
      file_browser = {
        theme = "ivy",
        hijack_netrw = true,
      },
      frecency = {
        db_safe_mode = false,
      },
      lazy_plugins = {
        lazy_spec_table = vim.fn.stdpath("config") .. "/init.lua",
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
  require("telescope").load_extension("lazy_plugins")
end

return M
