--[[
Ranger embedded in a nice floating window with RPC additions to smooth things over.
--]]

return {
  "kevinhwang91/rnvimr",
  keys = {
    { "<leader>or", "<cmd>RnvimrToggle<cr>", desc = "File browser" },
  },
  cmd = "RnvimrToggle",
  config = function()
    vim.g.rnvimr_draw_border = 1
    vim.g.rnvimr_pick_enable = 1
    vim.g.rnvimr_bw_enable = 1
  end,
}
