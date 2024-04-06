--[[
Where I set all the options/commands I use in the config.

Anything related specifically to neovide lives in its plugin file

To save me having to document every single line, I would encourage you to use `:h` to inspect each option. The built-in documentation is much better than any series of words I can produce.
--]]

-- From https://github.com/tjdevries/config_manager/blob/b1bd25a063326d4a1d35439c2c3af42c465347ab/xdg_config/nvim/lua/tj/globals.lua
local require = require

local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader = require
if ok then
  reloader = plenary_reload.reload_module
end

_G.P = function(v)
  print(vim.inspect(v))
  return v
end

local RELOAD = function(...)
  local _ok, _plenary_reload = pcall(require, "plenary.reload")
  if _ok then
    reloader = _plenary_reload.reload_module
  end

  return reloader(...)
end

_G.R = function(name)
  RELOAD(name)
  return require(name)
end

-- Setup leader key to be <Space> and localleader to be comma
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.termguicolors = true
vim.g.formatoptions = "qrn1"
vim.opt.showmode = false
vim.opt.timeoutlen = 300
vim.opt.updatetime = 100
vim.wo.signcolumn = "yes"
vim.opt.scrolloff = 10
vim.opt.wrap = false
vim.opt.ttimeoutlen = 5
vim.opt.virtualedit = "block"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"
vim.opt.shell = "/bin/zsh"
vim.opt.cursorline = true
vim.opt.autochdir = true

-- Spelling is gud sumtims
vim.opt.spelllang = "en_gb"
vim.opt.spell = true

-- Ignore case when searching if applicable
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Shorter messages
vim.opt.shortmess:append("c")

-- Indent Settings
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.wrap = true

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"

-- Characters to display in certain circumstances
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = {
  vert = "│",
  fold = "⠀",
  eob = " ", -- suppress ~ at EndOfBuffer
  --diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
}

-- Prefer ripgrep if it exists
if vim.fn.executable("rg") > 0 then
  vim.o.grepprg = "rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*"
  vim.opt.grepformat = vim.opt.grepformat ^ { "%f:%l:%c:%m" }
end

-- Firenvim setup
function _G.FirenvimSetup(channel)
  local channel_info = vim.api.nvim_get_chan_info(channel)
  if channel_info.client and channel_info.client.name == "Firenvim" then
    vim.opt.laststatus = 0

    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
      nested = true,
      callback = function()
        if vim.g.timer_started == true then
          return
        end
        vim.g.timer_started = true
        vim.fn.timer_start(3000, function()
          vim.g.timer_started = false
          vim.cmd("write")
        end)
      end,
    })
  end
end

vim.cmd("autocmd UIEnter * call v:lua.FirenvimSetup(deepcopy(v:event.chan))")

-- Change the default diagnostic signs used (requires a nerd font or fallback)
local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

-- Sign column changes
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Virtual text changes
vim.diagnostic.config({
  virtual_text = {
    prefix = " " .. signs.Warn,
  },
})

--[[
Autocommands are a way for neovim to run specific code on specific events.

They're extremely useful for doing things say when a buffer is opened or saved, when LSP is attached, when text is modified etc.

As always, consult the help docs `:h` as they will do a much more superior job than I.
--]]

-- Jump to last line when opening a file
-- The more I touch this to try and make it work with Lua API, the more it randomly breaks so I concede.
vim.cmd([[
    au BufWinEnter * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif
]])

-- Make containing directory if missing
vim.api.nvim_create_autocmd("BufWritePre", {
  command = "silent! Mkdir!",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("hi-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
