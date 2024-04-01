--[[
As great as tools like tmux are, they don't ALWAYS fit; and often come with their own issues.

Rather than relying on an external tool and panicking when I'm without it, we can instead use a package to allow use to create our own toggleable terminal buffers.
--]]

return {
  "akinsho/nvim-toggleterm.lua",
  keys = {
    {
      "<leader>cg",
      function()
        require("toggleterm.terminal").Terminal
          :new({
            dir = vim.fn.stdpath("config"),
            cmd = "lazygit",
            direction = "float",
          })
          :toggle()
      end,
      desc = "Lazygit",
    },
    { "<leader>ot", "<cmd>ToggleTerm<cr>", desc = "Lazygit" },
    {
      "<leader>oD",
      function()
        require("toggleterm.terminal").Terminal
          :new({
            cmd = "lazydocker",
            direction = "float",
          })
          :toggle()
      end,
      desc = "Lazydocker",
    },
    {
      "<leader>gg",
      function()
        require("toggleterm.terminal").Terminal
          :new({
            cmd = "lazygit",
            direction = "float",
          })
          :toggle()
      end,
      desc = "Lazygit",
    },
  },
  config = function()
    require("toggleterm").setup({
      direction = "horizontal",
      shell = vim.o.shell, -- change the default shell
      shade_terminals = true,
      float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "double",
        winblend = 0,
        highlights = { border = "Normal", background = "Normal" },
      },
    })

    -- Easier escape from terminal buffers
    vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", { noremap = true, silent = true })
  end,
}
