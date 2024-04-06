--[[
The main entrypoint after loading. Here is where we setup all our options, define command where needed and setup autocommands.

The spec list that ends up being returned here is the "no-config" plugins that just get dropped in as a string or a simple spec that looks like

{
    "plugin_name",
    opts = {}
}

or something that for some reason breaks convention but has a blank setup function like

{
    "plugin_name",
    config = function()
        require("plugin_name.setup").setup({})
    end
}

For the sake of my argument, I'm defining configuration as having to modify opts or do things in config. Plugins that have multiple keys/ways to be lazy-loaded are fine.

Otherwise they'll end up as a module under `lua/plugins` here.
--]]

return {
  -- Most important package; the colour scheme
  -- This gets set in `after/plugin/colors.lua`
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme nordfox]])
    end,
  },

  -- Use TS to colourize matching delimiters. Not just brackets, HTML tags, do .. end in Lua/Elixir, etc
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({})
    end,
  },

  -- :w !sudo tee % > /dev/null
  {
    "lambdalisue/suda.vim",
    keys = {
      { "<leader>fU", "<cmd>SudaRead<cr>", desc = "Sudo read" },
      { "<leader>fS", "<cmd>SudaWrite<cr>", desc = "Sudo write" },
    },
    cmd = { "SudaWrite", "SudaRead" },
  },

  -- The tpope section
  -- Comment all the things
  "tpope/vim-commentary",

  -- Add "end" in ruby, lua, etc
  "tpope/vim-endwise",

  -- Unix helpers
  "tpope/vim-eunuch",

  -- The git plugin so good, it should be illegal
  "tpope/vim-fugitive",

  -- Enable repeating supported plugin maps with "."
  "tpope/vim-repeat",

  -- GitHub extension for fugitive.vim
  "tpope/vim-rhubarb",

  -- Increment dates/times
  "tpope/vim-speeddating",

  -- Git changes in the gutter
  {
    "lewis6991/gitsigns.nvim",
    lazy = vim.g.started_by_firenvim,
    opts = {},
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- Better QuickFix
  "kevinhwang91/nvim-bqf",

  -- Faster-than-light jumping
  -- Leap gets a free-pass since all we do is setup keybinds
  {
    "ggandor/leap.nvim",
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "-", "<Plug>(leap-forward)")
      vim.keymap.set({ "n", "x", "o" }, "_", "<Plug>(leap-backward)")
      vim.keymap.set({ "n", "x", "o" }, "gS", "<Plug>(leap-from-window)")
    end,
  },

  -- Automatic pair matching
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Delete buffers without wiping layout
  "famiu/bufdelete.nvim",

  -- Improve word motions
  -- CamelCaseACRONYMWords_underscore1234
  -- w--------------------------------->w
  -- e--------------------------------->e
  -- b<---------------------------------b
  --
  -- to
  --
  -- CamelCaseACRONYMWords_underscore1234
  -- w--->w-->w----->w---->w-------->w->w
  -- e-->e-->e----->e--->e--------->e-->e
  -- b<---b<--b<-----b<----b<--------b<-b
  "chaoren/vim-wordmotion",

  -- Link lines from repo host
  {
    "ruifm/gitlinker.nvim",
    keys = {
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("v")
        end,
        desc = "Yank link to current line",
        mode = "v",
      },
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("n")
        end,
        desc = "Yank link to current line",
      },
    },
    opts = {},
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- Lua language in help docs
  "milisims/nvim-luaref",

  -- Useful additions for tailwind
  -- Another exception here since this setting won't be needed post-10
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      document_color = {
        kind = vim.version().minor < 10 and "foreground" or "inline",
      },
    },
  },

  -- Multiple cursors
  "mg979/vim-visual-multi",
}
