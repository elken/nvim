return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<leader>od", "<cmd>DBUI<cr>", desc = "DB" },
    },
    init = function()
      ---@diagnostic disable-next-line: param-type-mismatch
      local base = vim.fs.joinpath(vim.fn.stdpath("state"), "db_ui")
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = base
      vim.g.db_ui_tmp_query_location = vim.fs.joinpath(base, "tmp")
    end,
  },
}
