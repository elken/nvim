--[[
Plugins that are part of the "mini.nvim" ecosystem, a set of packages all from the same author aiming to be minimal.

There's quite a few of these we like, so it made sense to group them in the same place (I'm allowed to break my own convention, it's mine)
--]]

return {
  {
    "echasnovski/mini.surround",
    version = "*",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "ys",
          delete = "ds",
          find = "",
          find_left = "",
          highlight = "",
          replace = "cs",
          update_n_lines = "",
          suffix_last = "",
          suffix_next = "",
        },
        search_method = "cover_or_next",
      })
      -- Remap adding surrounding to Visual mode selection
      vim.api.nvim_set_keymap("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
      -- Make special mapping for "add surrounding for line"
      vim.api.nvim_set_keymap("n", "yss", "ys_", { noremap = false })
    end,
  },
}
