--[[
An attempt to replicate the popular Emacs package org-mode; a document specification that has an _extremely_ rich ecosystem around it.

The Emacs package is nearly as old as I am, so of course it doesn't match Emacs in terms of functionality yet; but what is already there makes editing org very painless.
--]]

return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  config = function()
    local org = require("orgmode")

    org.setup({
      org_agenda_files = { "~/Nextcloud/org/agenda" },
      org_default_notes_file = "~/Nextcloud/org/Notes.org",
    })

    require("org-bullets").setup({
      concealcursor = true,
      symbols = {
        list = "‣",
        headlines = { "› " },
        checkboxes = {
          half = { "", "OrgTSCheckboxHalfChecked" },
          done = { "✓ ", "OrgDone" },
          todo = { "˟", "OrgTODO" },
        },
      },
    })
    require("headlines").setup()
  end,
  dependencies = {
    "nvim-orgmode/org-bullets.nvim",
    "lukas-reineke/headlines.nvim",
  },
}
