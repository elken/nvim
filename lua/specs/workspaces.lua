return {
  {
    "natecraddock/sessions.nvim",
    opts = {
      events = { "VimLeavePre", "WinEnter", "InsertLeave" },
      session_filepath = ".nvim/session",
    },
  },
  -- TODO: Revert back to upstream after https://github.com/natecraddock/workspaces.nvim/pull/41 is merged
  {
    "elken/workspaces.nvim",
    branch = "fix/nested-autocmd",
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
