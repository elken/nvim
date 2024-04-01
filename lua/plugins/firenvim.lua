--[[
Now this plugin is pure magic.

First follow this https://github.com/glacambre/firenvim?tab=readme-ov-file#installing

Then, _you get the full neovim in your browser_. Any text-based input you can interact with, you can pop up Neovim in place, edit as you would, then `ZZ`/`:wq`.

I would advise taking time to set this up, as there are extra considerations you might have to make based on your setup.
--]]

return {
  "glacambre/firenvim",
  build = function()
    vim.fn["firenvim#install"](0)
  end,
  lazy = not vim.g.started_by_firenvim,
  config = function()
    -- _Soon_ this can be removed
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = "(reddit|github).com_*.txt",
      command = "set filetype=markdown",
    })
    vim.g.firenvim_config = {
      globalSettings = { alt = "all" },
      localSettings = {
        [".*"] = {
          cmdline = "neovim",
          content = "text",
          priority = 0,
          selector = "textarea",
          takeover = "never",
        },
        ["https?://mail.google.com/"] = {
          takeover = "never",
          priority = 1,
        },
        ["https?://discord.com/"] = {
          takeover = "never",
          priority = 1,
        },
      },
    }
  end,
}
