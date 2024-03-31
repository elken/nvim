-- General config
--
-- Help documentation can be viewed with `:h <property>`
local fn = vim.fn

-- Save the local require here
local require = require

local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader = require
if ok then
  reloader = plenary_reload.reload_module
end

P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  local ok, plenary_reload = pcall(require, "plenary.reload")
  if ok then
    reloader = plenary_reload.reload_module
  end

  return reloader(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
-- Setup leader key to be space and localleader to be comma
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.did_load_filetypes = 1
vim.opt.termguicolors = true
vim.g.formatoptions = "qrn1"
vim.opt.guifont = "Iosevka Nerd Font Mono"
vim.opt.showmode = false
vim.opt.timeoutlen = 300
vim.opt.updatetime = 100
vim.wo.signcolumn = "yes"
vim.opt.scrolloff = 10
vim.opt.wrap = false
vim.opt.ttimeoutlen = 5
vim.opt.virtualedit = "block"
vim.opt.undofile = true
vim.opt.undodir = fn.stdpath("data") .. "undo"
vim.opt.shell = "/bin/zsh"
vim.opt.cursorline = true
vim.opt.winblend = 30
vim.opt.pumblend = 30

-- Ignore case when searching if applicable
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Shorter messages
vim.opt.shortmess:append("c")

-- Indent Settings
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.wrap = true

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"

-- Characters to display in certain circumstances
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = {
  vert = "│",
  fold = "⠀",
  eob = " ", -- suppress ~ at EndOfBuffer
  --diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
}

-- Prefer ripgrep if it exists
if fn.executable("rg") > 0 then
  vim.o.grepprg = "rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*"
  vim.opt.grepformat = vim.opt.grepformat ^ { "%f:%l:%c:%m" }
end

-- Firenvim setup
-- function _G.FirenvimSetup(channel)
--   local channel_info = vim.api.nvim_get_chan_info(channel)
--   if channel_info.client and channel_info.client.name == "Firenvim" then
--     vim.opt.laststatus = 0
--   end
-- end

-- vim.cmd("autocmd UIEnter * call v:lua.FirenvimSetup(deepcopy(v:event.chan))")

-- Get a project root from vimL
function _G.get_project_root()
  return require("project_nvim.project").get_project_root()
end

-- Jump to last line when opening a file
vim.cmd([[
 au BufWinEnter * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif
]])

-- Change directory to the current buffer
vim.g.autochdir = true

-- Make containing directory if missing
vim.api.nvim_create_autocmd("BufWritePre", {
  command = "silent! Mkdir!",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("hi-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Install lazy.nvim if it's missing
-- NOTE: This is where things get bootstrapped
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--@diagnostic disable-next-line: undefine-field
if not vim.loop.fs_stat(lazypath) and not vim.g.started_by_firenvim then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Start of plugin config
require("lazy").setup({
  -- Most important package; the colour scheme
  "EdenEast/nightfox.nvim",

  -- Add fancy indent markers, which integrate nicely with treesitter
  -- and shows the current context
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }

      require("ibl").setup({
        scope = { highlight = highlight },
        exclude = {
          filetypes = {
            "startify",
            "dashboard",
            "log",
            "fugitive",
            "gitcommit",
            "vimwiki",
            "txt",
            "vista",
            "help",
            "todoist",
            "NvimTree",
            "git",
            "TelescopePrompt",
            "undotree",
            "flutterToolsOutline",
            "", -- for all buffers without a file type
          },
        },
      })

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },

  -- Use TS to colourize matching delimiters. Not just brackets, HTML tags, do .. end in Lua/Elixir, etc
  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({})
    end,
  },

  -- Pointless rice project; the statusline. Pick a nice one that works
  -- ootb and leave it there.
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config.lualine").setup()
    end,
    requires = {
      "kyazdani42/nvim-web-devicons",
      "rlch/github-notifications.nvim",
    },
  },

  -- Which key is that? Which-key!
  {
    "folke/which-key.nvim",
    config = function()
      require("config.which-key").setup()
    end,
  },

  -- UI improvements
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        signature = { enabled = false },
        hover = { enabled = false },
        message = { enabled = false },
        -- override markdown rendering so that **cmp** and other plugins  **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, --  a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  -- Highlight colours (sometimes, currently)
  {
    "norcalli/nvim-colorizer.lua",
    opts = {
      "css",
      "javascript",
      html = {
        mode = "foreground",
      },
    },
  },

  -- The big daddy
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope").setup()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "polirritmico/telescope-lazy-plugins.nvim",
      "nvim-lua/popup.nvim",
      "ahmedkhalf/project.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
  },

  -- 􏿽
  "chrisbra/unicode.vim",

  -- :w !sudo tee % > /dev/null
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaWrite", "SudaRead" },
  },

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

  --  Quoting/parenthesizing made simple
  "tpope/vim-surround",

  {
    "folke/neodev.nvim",
    lazy = false,
    dependencies = {
      "folke/neoconf.nvim",
    },
  },

  -- Pretty good test runner
  {
    "nvim-neotest/neotest",
    lazy = true,
    keys = {
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle summary",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.run(vim.fn.getcwd())
        end,
        desc = "Run whole suite",
      },
      {
        "<leader>tw",
        function()
          require("neotest").watch.toggle(vim.fn.getcwd())
        end,
        desc = "Run whole suite in watch mode",
      },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rspec")({
            filter_dirs = { "vendor" },
            rspec_cmd = function(position_type)
              if position_type == "test" then
                return vim.tbl_flatten({
                  "bundle",
                  "exec",
                  "rspec",
                  "--fail-fast",
                })
              else
                return vim.tbl_flatten({
                  "bundle",
                  "exec",
                  "rspec",
                })
              end
            end,
          }),
        },
      })
    end,
    dependencies = {
      "olimorris/neotest-rspec",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
  },

  -- Syntax and speed
  -- Sitting in a tree
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter").setup()
    end,
    dependencies = {
      "RRethy/nvim-treesitter-textsubjects", -- Location & syntax-aware text objects
      "nvim-treesitter/nvim-treesitter-textobjects", -- Custom objects using treesitter
      "JoosepAlviste/nvim-ts-context-commentstring", -- Correctly guess which comment to  in a mixed-mode file
    },
  },

  -- Neovim anywhere
  {
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
  },

  -- Git changes in the gutter
  {
    "lewis6991/gitsigns.nvim",
    lazy = vim.g.started_by_firenvim,
    opts = {},
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
  },

  -- WIP Magit
  -- Not good enough yet, but getting there
  {
    "NeogitOrg/neogit",
    opts = {
      graph_style = "unicode",
      integrations = {
        telescope = true,
        diffview = true,
      },
    },
    lazy = vim.g.started_by_firenvim,
    dependencies = {
      "sindrets/diffview.nvim",
      "nvim-lua/plenary.nvim",
    },
  },

  -- WIP orgmode
  -- Not good enough yet, but getting there
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    config = function()
      local org = require("orgmode")

      org.setup({
        org_agenda_files = { "~/Nextcloud/org/agenda" },
        org_default_notes_file = "~/Nextcloud/org/Notes.org",
      })

      org.setup_ts_grammar()

      require("org-bullets").setup({
        symbols = {
          list = "‣",
          headlines = "› ",
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
      "akinsho/org-bullets.nvim",
      "lukas-reineke/headlines.nvim",
    },
  },

  -- Github integration (making issues etc)
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      default_remote = { "upstream", "elken", "origin" },
    },
  },

  -- Toggleable terminal buffer
  {
    "akinsho/nvim-toggleterm.lua",
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
  },

  -- Better QuickFix
  "kevinhwang91/nvim-bqf",

  -- Main DAP plugin
  -- TODO Get DAP setup neatly
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup({})
      local dap = require("dap")
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }
      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8088 })
      end
      dap.adapters.flutter = {
        type = "executable",
        command = "flutter",
        args = { "debug_adapter" },
      }
      vim.cmd([[
            nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
            nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
            nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
            nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
            nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
            nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
            nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
            ]])
    end,
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "jbyuki/one-small-step-for-vimkind",
    },
  },

  -- UI for above
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    after = "nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
  },

  -- EZ installer for DAP servers
  {
    "Pocco81/dap-buddy.nvim",
    config = function()
      local dap = require("dap-install")

      local debugger_list = require("dap-install.debuggers_list").debuggers

      for debugger, _ in pairs(debugger_list) do
        dap.config(debugger, {})
      end
    end,
    cmd = { "DIInstall", "DIUninstall", "DIList" },
  },

  -- Fancy IDE stuff
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.lspconfig").setup()
    end,
    dependencies = {
      "folke/which-key.nvim",
      {
        "williamboman/mason.nvim",
        build = function()
          local ensure_installed = {
            "bash-language-server",
            "clj-kondo",
            "cljfmt",
            "clojure_lsp",
            "docker-compose-language-server",
            "dockerfile-language-server",
            "dot-language-server",
            "elixir-ls",
            "emmet-ls",
            "html-lsp",
            "json-lsp",
            "lua-language-server",
            "lua_ls",
            "markdownlint",
            "mdformat",
            "prettierd",
            "rustywind",
            "shellcheck",
            "shfmt",
            "sql-formatter",
            "stylua",
            "tailwindcss-language-server",
            "taplo",
            "terraform-ls",
            "typst-lsp",
            "typstfmt",
            "vale",
            "vim-language-server",
          }
          return ":MasonInstall " .. table.concat(ensure_installed, " ")
        end,
      },
      "williamboman/mason-lspconfig.nvim",
      "ray-x/lsp_signature.nvim",
      {
        "smjonas/inc-rename.nvim",
        opts = {},
      },
    },
  },

  -- Completion framework
  -- TODO Customize the new popup window
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("config.cmp").setup()
    end,
    dependencies = {
      "nvim-treesitter",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip").filetype_extend("ruby", { "rails" })
            end,
          },
        },
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
    },
  },

  -- Faster-than-light jumping
  "ggandor/lightspeed.nvim",

  -- Automatic pair matching
  "LunarWatcher/auto-pairs",

  -- Formatting
  "dense-analysis/ale",

  -- Telescope most recently used
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = { "tami5/sqlite.lua" },
  },

  -- Free real estate for startup perf
  "nathom/filetype.nvim",

  -- File browser (depends on ranger)
  {
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end,
  },

  -- Trying out nvimtree, probably won't last
  {
    "kyazdani42/nvim-tree.lua",
    opts = {},
    dependencies = "kyazdani42/nvim-web-devicons",
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
    opts = {},
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- Clipboard manager
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "tami5/sqlite.lua", module = "sqlite" },
  },

  -- Named well, tree of undos
  "mbbill/undotree",

  -- Better mapping tools
  -- NOTE This is dead now, as I add more bindings this should migrate elsewhere
  {
    "b0o/mapx.nvim",
    config = function()
      require("config.mappings").setup()
    end,
  },

  -- Flutter tools
  {
    "akinsho/flutter-tools.nvim",
    config = function()
      require("flutter-tools").setup({
        widget_guides = {
          enabled = true,
        },
        lsp = {
          color = {
            enabled = true,
          },
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
          register_configurations = function(_)
            require("dap").configurations.dart = {}
            require("dap.ext.vscode").load_launchjs()
            -- require("dap.ext.vscode").load_launchjs(vim.lsp.buf.list_workspace_folders()[1] .. "/.vscode/launch.json")
          end,
        },
      })
    end,
    dependencies = "nvim-lua/plenary.nvim",
    after = "nvim-dap",
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },

    init = function()
      -- UFO folding
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
    end,
  },

  -- Lua language in help docs
  "milisims/nvim-luaref",

  -- Allow jumping between "alternative" files (eg tests and their source files)
  {
    "rgroli/other.nvim",
    keys = {
      {
        "go",
        "<cmd>Other<cr>",
        desc = "Other file",
      },
    },
    config = function()
      require("other-nvim").setup({
        mappings = {
          "laravel",
          "livewire",
          -- Lib -> Test
          {
            pattern = "/lib/(.*).rb",
            target = {
              { context = "test", target = "/spec/%1_spec.rb" },
            },
          },
          -- Test -> Lib
          {
            pattern = "/spec/(.*)_spec.rb",
            target = {
              { context = "source", target = "/lib/%1.rb" },
            },
          },
        },
        style = {
          border = "rounded",
        },
      })
    end,
  },
  -- Useful additions for tailwind
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
})
