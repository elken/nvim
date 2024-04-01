-- Pretty good test runner
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
      desc = "Run whole suite",
    },
    {
      "<leader>tw",
      function()
        require("neotest").watch.toggle(vim.fn.getcwd())
      end,
      desc = "Run whole suite in watch mode",
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rspec")({
          filter_dirs = { "vendor" },
          rspec_cmd = function(position_type)
            if position_type == "test" then
              return vim.tbl_flatten({
                "bundle",
                "exec",
                "rspec",
                "--fail-fast",
              })
            else
              return vim.tbl_flatten({
                "bundle",
                "exec",
                "rspec",
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
