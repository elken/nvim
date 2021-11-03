-- General config
--
-- Help documentation can be viewed with `:h <property>`
local fn = vim.fn

-- Only run these settings once
if not packer_plugins then
  vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
  vim.opt.termguicolors = true
end

vim.g.did_load_filetypes = 1
vim.g.formatoptions = "qrn1"
vim.opt.guifont = "Iosevka Nerd Font Mono"
vim.opt.showmode = false
vim.opt.timeoutlen = 500
vim.opt.updatetime = 100
vim.wo.signcolumn = "yes"
vim.opt.scrolloff = 5
vim.opt.wrap = false
vim.opt.ttimeoutlen = 5
vim.opt.virtualedit = "block"
vim.opt.undofile = true
vim.opt.undodir = fn.stdpath("data") .. "undo"
vim.opt.shell = "/bin/zsh"

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
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.wrap = true

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"

-- Fillchars
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
function _G.FirenvimSetup(channel)
  local channel_info = vim.api.nvim_get_chan_info(channel)
  if channel_info.client and channel_info.client.name == "Firenvim" then
    vim.opt.laststatus = 0
  end
end

vim.cmd("autocmd UIEnter * call v:lua.FirenvimSetup(deepcopy(v:event.chan))")

-- Get a project root from vimL
function _G.get_project_root()
  return require("project_nvim.project").get_project_root()
end

-- Jump to last line when opening a file
vim.cmd([[
	au BufWinEnter * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif
]])

-- Run PackerCompile after saving init.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])

-- Change directory to the current buffer
vim.cmd("autocmd BufEnter * silent! lcd %:p:h")

-- Make containing directory if missing
vim.cmd("autocmd BufWritePre * silent! Mkdir! ")

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- Installed packer if it's missing
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd("autocmd VimEnter * PackerSync")
end

return require("packer").startup({
  function(use)
    -- Only load a package on macos
    local use_mac = function(opts)
      if vim.fn.has("macos") == 0 then
        return
      end

      use(opts)
    end

    -- Packer (needed to manage packer packages to manage packages to manage...)
    use("wbthomason/packer.nvim")

    -- Most important package; the colour scheme
    use({
      "shaunsingh/nord.nvim",
      requires = "folke/lsp-colors.nvim",
    })

    -- Add fancy indent markers, which integrate nicely with treesitter
    -- and shows the current context
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("indent_blankline").setup({
          filetype_exclude = {
            "startify",
            "dashboard",
            "dotooagenda",
            "log",
            "fugitive",
            "gitcommit",
            "packer",
            "vimwiki",
            "markdown",
            "json",
            "txt",
            "vista",
            "help",
            "todoist",
            "NvimTree",
            "peekaboo",
            "git",
            "TelescopePrompt",
            "undotree",
            "flutterToolsOutline",
            "", -- for all buffers without a file type
          },
          buftype_exclude = { "help", "terminal", "nofile" },
          use_treesitter = true,
          show_current_context = true,
          max_indent_increase = 1,
          context_patterns = {
            "table",
            "class",
            "function",
            "method",
            "^if",
            "while",
            "for",
            "with",
            "func_literal",
            "block",
            "try",
            "except",
            "argument_list",
            "object",
            "dictionary",
            "element",
          },
        })
      end,
    })

    -- Pointless rice project; the statusline. Pick a nice one that works
    -- ootb and leave it there.
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("config.lualine").setup()
      end,
      requires = {
        "arkav/lualine-lsp-progress",
        "kyazdani42/nvim-web-devicons",
        "rlch/github-notifications.nvim",
      },
    })

    -- Which key is that? Which-key!
    use({
      "folke/which-key.nvim",
      config = function()
        require("config.which-key").setup()
      end,
    })

    -- Highlight colours (sometimes, currently)
    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end,
    })

    -- The big daddy
    use({
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      module = "telescope",
      config = function()
        require("config.telescope").setup()
      end,
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        -- "ahmedkhalf/project.nvim"
        "~/build/project.nvim",
      },
    })

    -- 􏿽
    use("chrisbra/unicode.vim")

    -- :w !sudo tee % > /dev/null
    use({
      "lambdalisue/suda.vim",
      cmd = { "SudaWrite", "SudaRead" },
    })

    -- Comment all the things
    use("tpope/vim-commentary")

    -- Add "end" in ruby, lua, etc
    use("tpope/vim-endwise")

    -- Unix helpers
    use("tpope/vim-eunuch")

    -- The git plugin so good, it should be illegal
    use("tpope/vim-fugitive")

    -- Enable repeating supported plugin maps with "."
    use("tpope/vim-repeat")

    -- GitHub extension for fugitive.vim
    use("tpope/vim-rhubarb")

    -- Increment dates/times
    use("tpope/vim-speeddating")

    --  Quoting/parenthesizing made simple
    use("tpope/vim-surround")

    -- Pretty good test runner
    use({
      "rcarriga/vim-ultest",
      run = ":UpdateRemotePlugins",
      requires = "vim-test/vim-test",
    })

    -- Syntax and speed
    -- Sitting in a tree
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        "RRethy/nvim-treesitter-textsubjects", -- Location & syntax-aware text objects
        "nvim-treesitter/nvim-treesitter-textobjects", -- Custom objects using treesitter
        "nvim-treesitter/nvim-treesitter-refactor", -- Slightly better refactorings
        "JoosepAlviste/nvim-ts-context-commentstring", -- Correctly guess which comment to use in a mixed-mode file
        "p00f/nvim-ts-rainbow", -- 🌈
        "spywhere/detect-language.nvim", -- Whose ls is it anyway?
        "nvim-treesitter/playground", -- Debug tool for treesitter
      },
    })

    -- TODO Set this up
    -- use {
    --     "nvim-treesitter/nvim-tree-docs",
    --     requires = {
    --         {"nvim-treesitter/nvim-treesitter"},
    --     },
    -- }

    -- Neovim anywhere
    -- TODO Refine this (remove barbar etc)
    use({
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end,
      config = function()
        -- _Soon_ this can be removed
        vim.cmd([[
                au BufEnter github.com_*.txt set filetype=markdown
                au BufEnter reddit.com_*.txt set filetype=markdown
                let g:firenvim_config = { "globalSettings": { "alt": "all", }, "localSettings": { ".*": { "cmdline": "neovim", "content": "text", "priority": 0, "selector": "textarea", "takeover": "always", }, } }
                let fc = g:firenvim_config["localSettings"]
                let fc["https?://mail.google.com/"] = { "takeover": "never", "priority": 1 }
                let fc["https?://discord.com/"] = { "takeover": "never", "priority": 1 }
            ]])
      end,
    })

    -- Git changes in the gutter
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup({
          keymaps = {},
        })
      end,
      requires = "nvim-lua/plenary.nvim",
    })

    -- Better markdown editing
    -- use {
    --     "SidOfc/mkdx",
    --     config = function ()
    --     end
    -- }

    -- Markdown preview
    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install",
      config = function()
        vim.g.mkdp_browser = "firefox"
      end,
    })

    -- WIP Magit
    -- Not good enough yet, but getting there
    use({
      "TimUntersberger/neogit",
      config = function()
        require("neogit").setup({
          integrations = {
            diffview = true,
          },
        })
      end,
      requires = {
        "sindrets/diffview.nvim",
        "nvim-lua/plenary.nvim",
      },
    })

    -- WIP orgmode
    -- Not good enough yet, but getting there
    use({
      "kristijanhusak/orgmode.nvim",
      branch = "tree-sitter",
      config = function()
        require("orgmode").setup({
          org_agenda_files = { "~/Nextcloud/org" },
          org_default_notes_file = "~/Nextcloud/org/Notes.org",
        })
        require("org-bullets").setup({
          symbols = { "›" },
        })
        require("headlines").setup()
      end,
      requires = {
        "akinsho/org-bullets.nvim",
        "lukas-reineke/headlines.nvim",
      },
    })

    -- Github integration (making issues etc)
    use({
      "pwntester/octo.nvim",
      cmd = "Octo",
      config = function()
        require("octo").setup({
          default_remote = { "upstream", "elken", "origin" },
        })
      end,
    })

    -- Toggleable terminal buffer
    use({
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
    })

    -- Tab bar plugin
    -- TODO Hide this in firenvim
    use({
      "akinsho/bufferline.nvim",
      config = function()
        require("bufferline").setup({
          options = {
            diagnostics = "nvim_lsp",
            separator_style = "slant",
            always_show_bufferline = false,
          },
        })
      end,
      requires = "kyazdani42/nvim-web-devicons",
    })

    -- Better QuickFix
    use("kevinhwang91/nvim-bqf")

    -- Main DAP plugin
    -- TODO Get DAP setup neatly
    use({
      "mfussenegger/nvim-dap",
      config = function()
        -- require("nvim-dap-virtual-text").setup()
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
      module = "dap",
      requires = {
        "theHamsta/nvim-dap-virtual-text",
        "jbyuki/one-small-step-for-vimkind",
      },
    })

    -- UI for above
    use({ "rcarriga/nvim-dap-ui", after = "nvim-dap" })

    -- EZ installer for DAP servers
    use({
      "Pocco81/DAPInstall.nvim",
      config = function()
        local dap = require("dap-install")

        local debugger_list = require("dap-install.debuggers_list").debuggers

        for debugger, _ in pairs(debugger_list) do
          dap.config(debugger, {})
        end
      end,
      cmd = { "DIInstall", "DIUninstall", "DIList" },
    })

    -- Fancy IDE stuff
    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("config.lspconfig").setup()
      end,
      after = "which-key.nvim",
      requires = {
        "williamboman/nvim-lsp-installer",
        "ray-x/lsp_signature.nvim",
      },
    })

    -- Completion framework
    -- TODO Customize the new popup window
    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("config.cmp").setup()
      end,
      requires = {
        "nvim-treesitter",
        "hrsh7th/cmp-nvim-lsp",
        "onsails/lspkind-nvim",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
      },
    })

    -- Faster-than-light jumping
    use("ggandor/lightspeed.nvim")

    -- Automatic pair matching
    use("LunarWatcher/auto-pairs")

    -- Async Lint Engine
    use("dense-analysis/ale")

    -- Telescope most recently used
    use({
      "nvim-telescope/telescope-frecency.nvim",
      requires = { "tami5/sqlite.lua" },
    })

    -- Simple popup notification library
    use({
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
      end,
    })

    -- Free real estate for startup perf
    use("nathom/filetype.nvim")

    -- File browser (depends on ranger)
    use({
      "kevinhwang91/rnvimr",
      config = function()
        vim.g.rnvimr_ranger_cmd = 'HIGHLIGHT_STYLE=nord ranger --cmd="set draw_borders both"'
      end,
    })

    -- Trying out nvimtree, probably won't last
    use({
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-tree").setup({})
      end,
    })

    -- Delete buffers without wiping layout
    use("famiu/bufdelete.nvim")

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
    use("chaoren/vim-wordmotion")

    -- Link lines from repo host
    use({
      "ruifm/gitlinker.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("gitlinker").setup()
      end,
    })

    -- Clipboard manager
    use({
      "AckslD/nvim-neoclip.lua",
      requires = { "tami5/sqlite.lua", module = "sqlite" },
    })

    -- Dim inactive buffers
    -- use({
    --   "sunjon/shade.nvim",
    --   config = function()
    --     require("shade").setup({
    --       overlay_opacity = 50,
    --     })
    --   end,
    -- })

    -- Named well, tree of undos
    use("mbbill/undotree")

    -- Dash docs are pretty damn useful
    use_mac({
      "mrjones2014/dash.nvim",
      run = "make install",
    })
  end,
  config = {
    max_jobs = 50,
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  },
})
