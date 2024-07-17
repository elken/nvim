--[[
"Which key comes next? Oh darn I can't remember"

When you press a key in a non-insert mode, you get a little pop-up of the subsequent actions you can take.

Since we use a new enough version of nvim, we can specify the descriptions in the binds and this file just becomes basic prefix naming.
--]]

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local whichkey = require("which-key")
    whichkey.setup({
      preset = "helix",
      win = {
        wo = {
          winblend = vim.g.neovide and 30 or 0,
        },
      },
      plugins = {
        spelling = {
          enabled = true,
        },
      },
    })

    local normal_binds = {
      { "<leader>b", group = "Buffers" },
      { "<leader>b_", hidden = true },
      { "<leader>c", group = "Configuration" },
      { "<leader>c_", hidden = true },
      { "<leader>f", group = "File" },
      { "<leader>f_", hidden = true },
      { "<leader>g", group = "Git" },
      { "<leader>g_", hidden = true },
      { "<leader>h", group = "Help" },
      { "<leader>h_", hidden = true },
      { "<leader>o", group = "Open" },
      { "<leader>o_", hidden = true },
      { "<leader>oo", "<cmd>silent !open -a Finder.app /Users/ellis.kenyo/.config/nvim<CR>", desc = "Open directory in Finder" },
      { "<leader>p", group = "Projects" },
      { "<leader>p_", hidden = true },
      { "<leader>t", group = "Test" },
      { "<leader>t_", hidden = true },
      { "<leader>x", group = "Trouble" },
      { "<leader>x_", hidden = true },
    }

    whichkey.add(normal_binds)
  end,
}
