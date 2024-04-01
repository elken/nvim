--[[
Translate hex codes and color names to be highlighted as that colour. Excellent in complex CSS files to see which colours are being set from where, also just looks pretty.
--]]

return {
  "norcalli/nvim-colorizer.lua",
  opts = {
    "css",
    "javascript",
    html = {
      mode = "foreground",
    },
  },
}
