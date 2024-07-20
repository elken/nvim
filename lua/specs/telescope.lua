--[[
One of if not _the_ most useful plugins we install here.

Adds a new UI feature to allow various kinds of selections in a very fast interface.
--]]

return {
  "nvim-telescope/telescope.nvim",
  config = function()
    require("telescope").setup({
      extensions = {
        frecency = {
          db_safe_mode = false,
        },
        lazy_plugins = {
          lazy_config = vim.fn.stdpath("config") .. "/init.lua",
        },
        workspaces = {
          keep_insert = true,
        },
      },
    })
    require("telescope").load_extension("workspaces")
    if not vim.g.started_by_firenvim then
      require("telescope").load_extension("frecency")
    end
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("lazy_plugins")
    require("telescope").load_extension("fzf")
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "polirritmico/telescope-lazy-plugins.nvim",
    "nvim-lua/popup.nvim",
    {
      "nvim-telescope/telescope-frecency.nvim",
      dependencies = { "tami5/sqlite.lua" },
    },
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
}
