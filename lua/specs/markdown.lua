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
}
