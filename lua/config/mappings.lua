local M = {}

function M.setup()
	local mapx = require("mapx")

	-- Some IDE muscle memory
	mapx.vmap("<M-/>", "<cmd>Commentary<CR>", "silent")
	mapx.nnoremap("<C-s>", "<cmd>w<CR>", "silent")

	-- Better window swapping
	mapx.nnoremap("<C-h>", "<C-w>h")
	mapx.nnoremap("<C-j>", "<C-w>j")
	mapx.nnoremap("<C-k>", "<C-w>k")
	mapx.nnoremap("<C-l>", "<C-w>l")

	-- Quickly insert ; at the end of the line
	mapx.imap(";;", "<Esc>A;<Esc>")
end

return M
