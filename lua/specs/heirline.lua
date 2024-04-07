--[[
Setup for the various UI bars we have in play.

The global statusline is setup with heirline and the per-buffer bars are setup with incline.
--]]

return {
  {
    "rebelot/heirline.nvim",
    init = function()
      vim.opt.laststatus = 3
    end,
    config = function()
      local heirline = require("heirline")
      heirline.setup({
        statusline = require("specs.heirline.statusline"),
      })
    end,
  },
  {
    "b0o/incline.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      local helpers = require("incline.helpers")
      local devicons = require("nvim-web-devicons")
      local palette = require("nightfox.palette").load("nordfox")

      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local ro_icon = (not vim.bo[props.buf].modifiable or vim.bo[props.buf].readonly) and { "  ", guifg = palette.orange.base } or ""
          local res = {
            ro_icon,
            ft_icon and { " ", ft_icon, "  ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename, gui = modified and "bold" or "", guifg = modified and palette.yellow.dim or palette.fg },
            guibg = palette.bg0,
          }
          table.insert(res, " ")
          return res
        end,
      })
    end,
  },
}
