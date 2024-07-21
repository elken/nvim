--[[
An attempt to replicate the extremely popular Emacs package Magit; which aims to be a fancy editor-powered wrapper around Git.

I'll be honest since moving back to nvim, I have just been using lazygit; I really should give this another serious go around.
--]]

return {
  "NeogitOrg/neogit",
  cmd = { "Neogit" },
  keys = {
    {
      "<leader>gb",
      function()
        require("neogit").open({ "branch" })
      end,
      desc = "Open branch popup",
    },
  },
  opts = {
    graph_style = "unicode",
    integrations = {
      telescope = true,
      diffview = true,
    },
  },
  lazy = vim.g.started_by_firenvim,
  dependencies = {
    "sindrets/diffview.nvim",
    "nvim-lua/plenary.nvim",
  },
}
