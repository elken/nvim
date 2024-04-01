-- TODO Refactor this to use the new version API when 10 drops
if vim.version().minor < 9 then
  vim.api.nvim_echo(
    { { "You need to be on at least neovim 0.9 because that's what I'm on. Don't report errors if you see this, thanks!", "ErrorMsg" } },
    true,
    {}
  )
  return
end
-- First things first load all our global options
require("globals")

-- Then load all our keybindings
require("keybindings")

-- Install lazy.nvim if it's missing
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--@diagnostic disable-next-line: undefine-field
if not vim.loop.fs_stat(lazypath) and not vim.g.started_by_firenvim then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Last, bootstrap everything
require("lazy").setup("plugins", {
  dev = {
    path = "~/build/nvim/plugins",
  },
  ui = {
    border = vim.g.neovide and "rounded" or "none",
  },
})
