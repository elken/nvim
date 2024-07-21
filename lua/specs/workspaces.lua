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
          require("sessions").load(nil, { silent = true })
        end,
      },
    },
  },
}
