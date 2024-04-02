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

  return {
    {
      "xiyaowong/transparent.nvim",
      opts = {
        extra_groups = {
          "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
          "NvimTreeNormal", -- NvimTree
        },
      },
    },
  }
else
  return {}
end
