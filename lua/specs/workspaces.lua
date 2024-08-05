--[[
My dream team combo of workspaces and sessions.

Once adding a project directory, I have automatic session tracking for that project. Once I exit nvim and reopen, that session is popped right back up without me having to remember to do anything.

Over time I imagine I'll want more control over this but honestly for now this is great.
--]]

return {
  {
    "natecraddock/sessions.nvim",
    opts = {
      events = { "VimLeavePre", "WinEnter", "InsertLeave" },
      session_filepath = ".nvim/session",
    },
  },
  {
    "natecraddock/workspaces.nvim",
    dependencies = {
      "folke/noice.nvim",
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require("project_nvim").setup()
        end,
      },
    },
    opts = {
      auto_open = true,
      cd_type = "local",
      hooks = {
        open_pre = {
          -- If recording, save current session state and stop recording
          "SessionsStop",

          -- delete all buffers (does not save changes)
          ":Bdelete!",
        },
        open = function()
          if vim.fn.filereadable(".nvim/session") == 1 then
            local choice = vim.fn.confirm("Open the last session?", "&Yes\n&No")
            if choice == 1 then
              require("sessions").load(nil, { silent = true })
              return
            end
          end

          local function is_git_repo()
            vim.fn.system("git rev-parse --is-inside-work-tree")
            return vim.v.shell_error == 0
          end
          local function get_git_root()
            local dot_git_path = vim.fn.finddir(".git", ".;")
            return vim.fn.fnamemodify(dot_git_path, ":h")
          end
          local opts = {}
          if is_git_repo() then
            opts = {
              cwd = get_git_root(),
            }
          end
          require("telescope.builtin").find_files(opts)
        end,
      },
    },
  },
}
