--[[
I like to think that this package helped me secure my current role, and as such I'm a big fan of it.

Having the ability to show the entire test suite for the little toy task I had to write made it simple to demonstrate.

Neotest adds a bunch of lovely improvements around testing, including a summary window which when coupled with the watch setup allows you to get in-editor test feedback in a very graphical way.
--]]

return {
  "nvim-neotest/neotest",
  keys = {
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle summary",
    },
    {
      "<leader>ta",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "Run tests in project",
    },
    {
      "<leader>td",
      function()
        ---@diagnostic disable-next-line: missing-fields
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Run nearest test",
    },
    {
      "<leader>tr",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run current test file",
    },
    {
      "<leader>tn",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest test",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open()
      end,
      desc = "View test output",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output.open({ auto_close = true, enter = true })
      end,
      desc = "View test output",
    },
    {
      "<leader>tw",
      function()
        require("neotest").watch.toggle(vim.fn.getcwd())
      end,
      desc = "Run tests in project in watch mode",
    },
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("neotest").setup({
      adapters = {
        require("neotest-rspec")({
          filter_dirs = { "vendor" },
          rspec_cmd = function(position_type)
            if position_type == "test" then
              ---No viable alternative exists yet
              ---@diagnostic disable-next-line: deprecated
              return vim.tbl_flatten({
                "bin/rspec",
                "--fail-fast",
              })
            else
              ---No viable alternative exists yet
              ---@diagnostic disable-next-line: deprecated
              return vim.tbl_flatten({
                "bin/rspec",
              })
            end
          end,
        }),
      },
    })
  end,
  dependencies = {
    "olimorris/neotest-rspec",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
  },
}
