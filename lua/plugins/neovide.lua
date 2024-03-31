if vim.g.neovide then
  vim.opt.guifont = "Iosevka Nerd Font Mono,Symbols Nerd Font,Noto Color Emoji"
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = "railgun"

  return {}
else
  return {}
end
