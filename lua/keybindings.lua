-- Long-time muscle memory
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { silent = true, desc = "Save buffer" })

-- Slightly faster window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Global leader binds
vim.keymap.set("n", "<leader>;", "<cmd>nohl<cr>", { desc = "Turn off search highlight" })
vim.keymap.set("n", "<leader>l", ":lua ", { desc = "Open lua prompt" })
vim.keymap.set("n", "<leader>!", ":! ", { desc = "Open shell prompt" })
vim.keymap.set("n", "<leader>%", "<cmd>so %<cr>", { desc = "Reload current file" })

-- [B]uffer
vim.keymap.set("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Kill buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bp<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bn<cr>", { desc = "Next buffer" })

-- [F]ile
local function yank_to_clipboard(value)
  return function()
    vim.fn.setreg("+", vim.fn.expand(value))
  end
end

vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })
vim.keymap.set("n", "<leader>fd", function()
  local current_file = vim.fn.expand("%")
  local choice = vim.fn.confirm("Delete " .. current_file .. "?\n\nThis is an irrevocable action.", "&No\n&Yes")

  if choice == 2 then
    os.remove(current_file)
    vim.cmd("Bdelete")
  end
end, { desc = "Delete current file" })
vim.keymap.set("n", "<leader>fy", yank_to_clipboard("%:p"), { desc = "Yank file path" })
vim.keymap.set("n", "<leader>fY", yank_to_clipboard("%:~:."), { desc = "Yank file path" })

-- [O]pen
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

-- [G]it
vim.keymap.set("n", "<leader>gB", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
vim.keymap.set("n", "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns blame_line<cr>", { desc = "Previous hunk" })
vim.keymap.set("n", "<leader>gP", "<cmd>Gitsigns blame_line<cr>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns blame_line<cr>", { desc = "Reset current hunk" })
vim.keymap.set("n", "<leader>gR", "<cmd>Gitsigns blame_line<cr>", { desc = "Reset current buffer" })
vim.keymap.set("n", "<leader>gs", "<cmd>Gitsigns blame_line<cr>", { desc = "Stage current hunk" })
vim.keymap.set("n", "<leader>gS", "<cmd>Gitsigns blame_line<cr>", { desc = "Stage current buffer" })
vim.keymap.set("n", "<leader>gu", "<cmd>Gitsigns blame_line<cr>", { desc = "Undo stage hunk" })
vim.keymap.set("n", "<leader>gU", "<cmd>Gitsigns blame_line<cr>", { desc = "Reset buffer index" })

-- [H]elp/quick prompts
vim.keymap.set("n", "<leader>ht", "<cmd>Telescope help_tags<cr>", { desc = "Search help tags" })
vim.keymap.set("n", "<leader>hh", ":h ", { desc = "Open help prompt" })
