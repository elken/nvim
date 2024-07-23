--[[
Markdown is a format that's become extremely ubiquitous these days, so having a good editing experience for it is crucial.

Thankfully, all that's really needed is this one package.
--]]

return {
  {
    "MeanderingProgrammer/markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  {
    "gpanders/vim-medieval",
    config = function()
      -- TODO: Add some kind of command to generate the results block and the comment
      vim.g.medieval_langs = { "python=python3", "ruby", "sh", "console=bash" }
    end,
  },
}
