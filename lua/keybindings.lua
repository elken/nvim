vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { silent = true, desc = "Save buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Kill buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bp<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bn<cr>", { desc = "Next buffer" })

vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })

local function yank_to_clipboard(value)
  return function()
    vim.fn.setreg("+", vim.fn.expand(value))
  end
end

vim.keymap.set("n", "<leader>fy", yank_to_clipboard("%:p"), { desc = "Yank file path" })
vim.keymap.set("n", "<leader>fY", yank_to_clipboard("%:~:."), { desc = "Yank file path" })

vim.keymap.set("n", "<leader>;", "<cmd>nohl<cr>", { desc = "Turn off search highlight" })

local function open_in_folder()
  local format = "<cmd>!xdg-open %s<cr>"
  if vim.fn.has("mac") == 1 then
    format = "<cmd>!open -a Finder.app %s<cr>"
  end
  return string.format(format, vim.fn.expand("%:p:h"))
end

local function open_in_folder_label()
  if vim.fn.has("mac") == 1 then
    return "Open current directory in Finder"
  end

  local default_fm = vim.fn.system({ "xdg-mime", "query", "default", "inode/directory" })

  return string.format("Open current directory in %s", default_fm:gsub(".desktop", ""):gsub("\n", ""):gsub("org.gnome.", ""))
end

vim.keymap.set("n", "<leader>oo", open_in_folder(), { desc = open_in_folder_label(), silent = true })

vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
vim.keymap.set("n", "<leader>hn", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns blame_line<cr>", { desc = "Previous hunk" })
vim.keymap.set("n", "<leader>hP", "<cmd>Gitsigns blame_line<cr>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns blame_line<cr>", { desc = "Reset current hunk" })
vim.keymap.set("n", "<leader>hR", "<cmd>Gitsigns blame_line<cr>", { desc = "Reset current buffer" })
vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns blame_line<cr>", { desc = "Stage current hunk" })
vim.keymap.set("n", "<leader>hS", "<cmd>Gitsigns blame_line<cr>", { desc = "Stage current buffer" })
vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns blame_line<cr>", { desc = "Undo stage hunk" })
vim.keymap.set("n", "<leader>hU", "<cmd>Gitsigns blame_line<cr>", { desc = "Reset buffer index" })
