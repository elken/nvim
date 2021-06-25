-- General config (mostly borrowed from vhyrro)
--
-- Help documentation can be viewed with `:h <property>`
require('plugins')
local fn = vim.fn

vim.g.mapleader = " "
vim.g.formatoptions = 'qrn1'
vim.opt.guifont = "Hasklug Nerd Font Mono"
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.timeoutlen = 500
vim.opt.updatetime = 100
vim.opt.scrolloff = 5
vim.opt.wrap = false
vim.opt.laststatus = 2
vim.opt.ttimeoutlen = 5
vim.opt.virtualedit = "block"
vim.opt.undodir = "~/.config/nvim/undo"

-- Create needed directories if not existing
for _, directory in pairs({ vim.o.undodir, vim.o.backupdir }) do
    if fn.isdirectory(fn.expand(directory)) == 0 then
	fn.system({'mkdir', '-p', fn.expand(directory)})
    end
end

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
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 8
vim.opt.softtabstop = 4

-- Completion
vim.opt.completeopt = "menuone,noselect"

-- Jump to last line when opening a file
vim.cmd[[    
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif
]]

-- Firenvim buffers
vim.cmd[[
    au BufEnter github.com_*.txt set filetype=markdown
    au BufEnter reddit.com_*.txt set filetype=markdown
]]

-- Change directory to the current buffer
vim.cmd[[
    autocmd BufEnter * silent! lcd %:p:h
]]

if fn.has('gui_running') then
    vim.g.lines = 999
    vim.g.columns = 999
end
