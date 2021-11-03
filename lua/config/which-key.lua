local M = {}

function M.setup()
  local whichkey = require("which-key")
  whichkey.setup({
    plugins = {
      spelling = {
        enabled = true,
      },
    },
  })

  local normal_binds = {
    b = {
      name = "Buffer",
      d = { "<cmd>Bdelete<CR>", "Kill buffer" },
      p = { "<cmd>bp<CR>", "Previous buffer" },
      n = { "<cmd>bn<CR>", "Next buffer" },
    },
    e = {
      name = "Edit Files",
      i = { "<cmd>e ~/.config/nvim/init.lua<CR>", "init.lua" },
    },
    f = {
      name = "File",
      f = {
        "<cmd>lua if not pcall(require('telescope.builtin').git_files, {}) then require('telescope.builtin').find_files() end<CR>",
        "Find file in project",
      },
      r = { "<cmd>Telescope frecency<CR>", "Find Recent File" },
      n = { "<cmd>enew<CR>", "New File" },
      s = { "<cmd>w<CR>", "Save file" },
      U = { "<cmd>SudaRead<CR>", "Sudo read" },
      S = { "<cmd>SudaWrite<CR>", "Sudo write" },
      y = { "<cmd>let @+ = expand('%:p')<CR>", "Yank file path" },
      Y = { "<cmd>let @+ = expand('%:~:.')<CR>", "Yank file path from project" },
      -- D = { "<cmd>lua require('util').confirm('Delete this file?', print('hi'))<CR>", "Delete this file" }
    },
    g = {
      name = "Git",
      b = { "<cmd>lua require('neogit').open({'branch'})<CR>", "Open branch popup" },
      D = { "<cmd>GDelete<CR>", "Delete current file from git" },
      f = { "<cmd>G fetch<CR>", "Fetch" },
      o = { "<cmd>GBrowse<CR>", "Open in browser" },
      g = {
        "<cmd>lua require('toggleterm.terminal').Terminal:new({cmd = 'lazygit', direction = 'float'}):toggle()<CR>",
        "Lazygit",
      },
      y = {
        "<cmd>lua require('gitlinker').get_buf_range_url('n')<CR>",
        "Yank link to current line",
      },
    },
    h = {
      name = "Hunk",
      b = { "<cmd>Gitsigns blame_line<CR>", "Blame line" },
      n = { "<cmd>Gitsigns next_hunk<CR>", "Next hunk" },
      p = { "<cmd>Gitsigns prev_hunk<CR>", "Previous hunk" },
      P = { "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
      s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage current hunk" },
      S = { "<cmd>Gitsigns stage_buffer<CR>", "Stage current buffer" },
      r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset current hunk" },
      R = { "<cmd>Gitsigns reset_buffer<CR>", "Reset current buffer" },
      u = { "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" },
      U = { "<cmd>Gitsigns reset_buffer_index<CR>", "Reset buffer index" },
    },
    p = {
      name = "Projects",
      p = { "<cmd>:Telescope projects<CR>", "Switch Project" },
    },
    o = {
      name = "Open",
      t = { "<cmd>ToggleTerm<CR>", "Terminal" },
      D = {
        "<cmd>lua require('toggleterm.terminal').Terminal:new({cmd = 'lazydocker', direction = 'float'}):toggle()<CR>",
        "Docker",
      },
      r = { "<cmd>RnvimrToggle<CR>", "Ranger" },
    },
    ["<space>"] = {
      "<cmd>lua if not pcall(require('telescope.builtin').git_files, {}) then require('telescope.builtin').find_files() end<CR>",
      "Find file in project",
    },
    [","] = { "<cmd>Telescope buffers<CR>", "Switch buffer" },
    ["."] = { "<cmd>Telescope file_browser<CR>", "Find file" },
    ["/"] = { "<cmd>Telescope live_grep<CR>", "Search in project" },
    [";"] = { "<cmd>nohl", "Turn off search highlight" },
  }

  local visual_binds = {
    g = {
      y = {
        "<cmd>lua require('gitlinker').get_buf_range_url('v')<CR>",
        "Yank link to current selection",
      },
    },
  }

  if vim.fn.has("mac") == 1 then
    normal_binds.o.o = {
      string.format("<cmd>silent !open -a Finder.app %s<CR>", vim.fn.expand("%:p:h")),
      "Open directory in Finder",
    }
  end

  whichkey.register(normal_binds, { prefix = "<leader>" })
  whichkey.register(vim.tbl_deep_extend("force", normal_binds, visual_binds), { prefix = "<leader>", mode = "v" })
end

return M
