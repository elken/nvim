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
      require("nightfox").setup({
        groups = {
          nordfox = {
            DapBreakpoint = { fg = "palette.red.bright" },

            Pmenu = { bg = "palette.bg0" },

            CmpItemAbbrDeprecated = { fg = "palette.comment", bg = "NONE", style = "strikethrough" },
            CmpItemAbbrMatch = { fg = "palette.cyan", bg = "NONE", style = "bold" },
            CmpItemAbbrMatchFuzzy = { fg = "palette.cyan", bg = "NONE", style = "bold" },
            CmpItemMenu = { fg = "palette.magenta.dim", bg = "NONE", style = "italic" },

            CmpItemKindField = { fg = "palette.fg0", bg = "palette.red.dim" },
            CmpItemKindProperty = { fg = "palette.fg0", bg = "palette.red.dim" },
            CmpItemKindEvent = { fg = "palette.fg0", bg = "palette.red.dim" },

            CmpItemKindText = { fg = "palette.fg0", bg = "palette.green.dim" },
            CmpItemKindEnum = { fg = "palette.fg0", bg = "palette.green.dim" },
            CmpItemKindKeyword = { fg = "palette.fg0", bg = "palette.green.dim" },

            CmpItemKindConstant = { fg = "palette.fg0", bg = "palette.yellow.dim" },
            CmpItemKindConstructor = { fg = "palette.fg0", bg = "palette.yellow.dim" },
            CmpItemKindReference = { fg = "palette.fg0", bg = "palette.yellow.dim" },

            CmpItemKindFunction = { fg = "palette.fg0", bg = "palette.magenta.dim" },
            CmpItemKindStruct = { fg = "palette.fg0", bg = "palette.magenta.dim" },
            CmpItemKindClass = { fg = "palette.fg0", bg = "palette.magenta.dim" },
            CmpItemKindModule = { fg = "palette.fg0", bg = "palette.magenta.dim" },
            CmpItemKindOperator = { fg = "palette.fg0", bg = "palette.magenta.dim" },

            CmpItemKindVariable = { fg = "palette.fg3", bg = "palette.bg3" },
            CmpItemKindFile = { fg = "palette.fg3", bg = "palette.bg3" },

            CmpItemKindUnit = { fg = "palette.fg0", bg = "palette.orange.dim" },
            CmpItemKindSnippet = { fg = "palette.fg0", bg = "palette.orange.dim" },
            CmpItemKindFolder = { fg = "palette.fg0", bg = "palette.orange.dim" },

            CmpItemKindMethod = { fg = "palette.fg0", bg = "palette.blue.dim" },
            CmpItemKindValue = { fg = "palette.fg0", bg = "palette.blue.dim" },
            CmpItemKindEnumMember = { fg = "palette.fg0", bg = "palette.blue.dim" },

            CmpItemKindInterface = { fg = "palette.fg0", bg = "palette.cyan.dim" },
            CmpItemKindColor = { fg = "palette.fg0", bg = "palette.cyan.dim" },
            CmpItemKindTypeParameter = { fg = "palette.fg0", bg = "palette.cyan.dim" },
          },
        },
      })
      vim.cmd("colorscheme nordfox")
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

  -- Jumping in a flash
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- TODO: but nicer
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    opts = {},
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

  -- Improved handling of splits across terminal
  {
    "mrjones2014/smart-splits.nvim",
    opts = {},
  },

  -- Tint inactive buffers
  {
    "levouh/tint.nvim",
    opts = {
      tint = -35,
      highlight_ignore_patterns = { "WinSeparator", "Status.*", "WinBar", "DAPUI.*" },
      tint_background_colors = true,
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufid })
        local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

        -- Do not tint `terminal` or floating windows, tint everything else
        return buftype == "terminal" or floating
      end,
    },
  },
}
