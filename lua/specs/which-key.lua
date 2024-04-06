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
      window = {
        winblend = vim.g.neovide and 30 or 0,
      },
      plugins = {
        spelling = {
          enabled = true,
        },
      },
    })

    local normal_binds = {
      b = {
        name = "Buffer",
        _ = "which_key_ignore",
      },
      c = {
        name = "Configuration",
        _ = "which_key_ignore",
      },
      f = {
        name = "File",
        _ = "which_key_ignore",
      },
      h = {
        name = "Help",
        _ = "which_key_ignore",
      },
      p = {
        name = "Projects",
        _ = "which_key_ignore",
      },
      o = {
        name = "Open",
        _ = "which_key_ignore",
      },
    }

    if vim.fn.has("mac") == 1 then
      normal_binds.o.o = {
        string.format("<cmd>silent !open -a Finder.app %s<CR>", vim.fn.expand("%:p:h")),
        "Open directory in Finder",
      }
    end

    whichkey.register(normal_binds, { prefix = "<leader>" })
  end,
}
