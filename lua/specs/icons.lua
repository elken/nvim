--[[
This package is used all over the place, so to me it's important that things I use often have appropriate icons.

Ideally this should be PR'd upstream.
--]]

return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    local devicons = require("nvim-web-devicons")
    local dotenv_icon, dotenv_color = devicons.get_icon_color(".env", ".env")
    local ruby_icon, _ = devicons.get_icon_color("test.rb", "rb")
    local ruby_color = "#a32a24"

    local icons = {
      rb = { icon = ruby_icon, color = ruby_color, name = "Rb" },
      rake = { icon = ruby_icon, color = ruby_color, name = "Rake" },
      rakefile = { icon = ruby_icon, color = ruby_color, name = "RakeFile" },
      gemfile = { icon = ruby_icon, color = ruby_color, name = "GemFile" },
      brewfile = { icon = ruby_icon, color = ruby_color, name = "BrewFile" },
      ["config.ru"] = { icon = ruby_icon, color = ruby_color, name = "config.ru" },
      [".ruby-version"] = { icon = ruby_icon, color = ruby_color, name = "config.ru" },
      jbuilder = { icon = ruby_icon, color = "#f7cd6d", name = "Jbuilder" },
      [".env.development"] = { icon = dotenv_icon, color = dotenv_color, name = ".env" },
      [".env.development.local"] = { icon = dotenv_icon, color = dotenv_color, name = ".env" },
      [".env.test"] = { icon = dotenv_icon, color = dotenv_color, name = ".env" },
      ["Procfile.dev"] = { icon = "󰫏", color = ruby_color, name = ".rspec" },
      [".rspec"] = { icon = "󰫏", color = ruby_color, name = ".rspec" },
      [".sonarcloud.properties"] = { icon = "󱇲", color = "#f3702a", name = "sonarcloud" },
      ["yarn.lock"] = { icon = "", color = "#ffffff", name = "yarn.lock" },
    }

    devicons.set_icon(icons)
  end,
}
