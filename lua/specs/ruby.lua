--[[
In classic tpope style, all that's needed is to include the packages.

No but really these are too new for me to know what I want to customize yet, as time progresses this module will be more than 3 lines.
--]]

return {
  {
    "tpope/vim-rails",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "eruby.yaml",
        command = "set filetype=yaml",
      })
    end,
  },
  "tpope/vim-rake",
  "tpope/vim-bundler",
}
