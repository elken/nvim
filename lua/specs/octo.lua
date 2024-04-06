--[[
Wrappers around various UI flows from Github, making it harder to leave the comfort of nvim.

Relying on `gh` to operate, this adds some nice UI around.

I have big ideas for replacing all the various git plugins I have, so stay tuned...
--]]

return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  opts = {
    default_remote = { "upstream", "elken", "origin" },
  },
}
