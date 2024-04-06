if vim.g.neovide then
  -- Setup default font with fallbacks
  vim.opt.guifont = "Iosevka Nerd Font,Symbols Nerd Font,Noto Color Emoji"

  -- Increase the resolution
  -- TODO Make this dynamic
  vim.g.neovide_refresh_rate = 144

  -- Keep the same window size on restart
  vim.g.neovide_remember_window_size = true

  -- Quake was fun, and having some guide to show your jumps turns out to be pretty useful
  vim.g.neovide_cursor_vfx_mode = "railgun"

  -- Add transparency
  vim.opt.winblend = 30
  vim.opt.pumblend = 30

  return {}
end

return {
  {
    "xiyaowong/transparent.nvim",
    lazy = not vim.g.neovide,
    opts = {
      extra_groups = {
        "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
        "NvimTreeNormal", -- NvimTree
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = vim.g.neovide,
    main = "ibl",
    opts = {},
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }

      require("ibl").setup({
        scope = { highlight = highlight },
        exclude = {
          filetypes = {
            "startify",
            "dashboard",
            "log",
            "fugitive",
            "gitcommit",
            "vimwiki",
            "txt",
            "vista",
            "help",
            "todoist",
            "NvimTree",
            "git",
            "TelescopePrompt",
            "undotree",
            "flutterToolsOutline",
            "", -- for all buffers without a file type
          },
        },
      })

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}
