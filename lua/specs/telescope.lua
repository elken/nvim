--[[
One of if not _the_ most useful plugins we install here.

Adds a new UI feature to allow various kinds of selections in a very fast interface.
--]]

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>cf",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find config file",
    },
    { "<leader>cs", "<cmd>Telescope lazy_plugins<cr>", desc = "Jump to spec" },
    {
      "<leader><space>",
      function()
        if not pcall(require("telescope.builtin").git_files, {}) then
          require("telescope.builtin").find_files()
        end
      end,
      desc = "Find file",
    },
    { "<leader>fr", "<cmd>Telescope frecency<cr>", desc = "Find Recent File" },
    { "<leader>pp", "<cmd>Telescope projects<cr>", desc = "Switch Project" },
    { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer" },
    { "<leader>.", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File browser" },
    { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Search in project" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        winblend = vim.g.neovide and 70 or 0,
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
    require("telescope").load_extension("projects")
    if not vim.g.started_by_firenvim then
      require("telescope").load_extension("frecency")
    end
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("lazy_plugins")
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "polirritmico/telescope-lazy-plugins.nvim",
    "nvim-lua/popup.nvim",
    "ahmedkhalf/project.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    {
      "nvim-telescope/telescope-frecency.nvim",
      dependencies = { "tami5/sqlite.lua" },
    },
    "nvim-telescope/telescope-ui-select.nvim",
  },
}
