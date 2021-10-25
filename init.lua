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
vim.opt.laststatus = 2
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

if fn.executable("rg") > 0 then
  vim.o.grepprg = "rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*"
  vim.opt.grepformat = vim.opt.grepformat ^ { "%f:%l:%c:%m" }
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
vim.cmd("autocmd BufWritePre * silent! Mkdir ")

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
    -- Packer (needed to manage packer packages to manage packages to manage...)
    use("wbthomason/packer.nvim")

    -- Most important package; the colour scheme
    use({
      "shaunsingh/nord.nvim",
      config = function()
        vim.g.nord_contrast = false
        vim.g.nord_borders = true

        if not vim.g.colourscheme_set then
          vim.cmd("colorscheme nord")
          vim.g.colourscheme_set = true
        end
      end,
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
        local function lsp_in_use()
          return table.maxn(vim.lsp.get_active_clients()) > 0
        end
        local function hide_in_width()
          return vim.fn.winwidth(0) > 80
        end
        local function buffer_not_empty()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end
        local function lsp_servers()
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local servers = vim.lsp.get_active_clients()
          local result = {}
          for _, v in ipairs(servers) do
            if not vim.tbl_contains(result, v.name) and vim.tbl_contains(v.config.filetypes, buf_ft) then
              table.insert(result, v.name)
            end
          end
          return (table.concat(result, ","))
        end

        require("lualine").setup({
          options = {
            theme = "nord",
            section_separators = { left = "", right = "" },
            component_separators = { left = "╲", right = "╱" },
          },
          sections = {
            lualine_a = {
              { "mode", separator = { left = "" } },
            },
            lualine_b = { { "branch", cond = hide_in_width } },
            lualine_c = {
              { "filetype", icon_only = true, separator = { right = "" }, padding = { left = 1 } },
              {
                lsp_servers,
                color = { gui = "bold" },
                cond = function()
                  return lsp_in_use() and hide_in_width()
                end,
              },
              {
                "filename",
                file_status = true,
                path = function()
                  if hide_in_width() then
                    return 1
                  else
                    return 2
                  end
                end,
                separator = { right = "" },
                cond = buffer_not_empty,
              },
              {
                "%=",
                separator = { left = "", right = "" },
              },
              "lsp-progress",
            },
            lualine_x = {
              { "diff", symbols = { added = " ", modified = " ", removed = " " } },
              { "diagnostics", sources = { "nvim_lsp" } },
            },
            lualine_y = {
              "encoding",
              {
                "fileformat",
                cond = function()
                  local options = {
                    unix = { "unix", "mac", "bsd", "wsl" },
                    mac = { "mac" },
                    dos = { "win32" },
                  }
                  for _, os in ipairs(options[vim.bo.fileformat]) do
                    if vim.fn.has(os) then
                      return false
                    end
                  end
                  return true
                end,
              },
            },
            lualine_z = {
              { "location", separator = { right = "" } },
            },
          },
          inactive_sections = {
            lualine_a = { "winnr" },
            lualine_b = {},
            lualine_c = { { "filename", cond = buffer_not_empty } },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
          },
          extensions = {
            "quickfix",
            "toggleterm",
            "fugitive",
          },
        })
      end,
      requires = {
        "arkav/lualine-lsp-progress",
        "kyazdani42/nvim-web-devicons",
      },
    })

    -- Which key is that? Which-key!
    use({
      "folke/which-key.nvim",
      config = function()
        local whichkey = require("which-key")
        whichkey.setup({
          plugins = {
            spelling = {
              enabled = true,
            },
          },
        })

        local normal_binds = {
          b = {
            name = "Buffer",
            d = { "<cmd>Bdelete<CR>", "Kill buffer" },
            p = { "<cmd>bp<CR>", "Previous buffer" },
            n = { "<cmd>bn<CR>", "Next buffer" },
          },
          e = {
            name = "Edit Files",
            i = { "<cmd>e ~/.config/nvim/init.lua<CR>", "init.lua" },
          },
          f = {
            name = "File",
            f = {
              "<cmd>lua if not pcall(require('telescope.builtin').git_files, {}) then require('telescope.builtin').find_files() end<CR>",
              "Find file in project",
            },
            r = { "<cmd>Telescope frecency<CR>", "Find Recent File" },
            n = { "<cmd>enew<CR>", "New File" },
            s = { "<cmd>w<CR>", "Save file" },
            U = { "<cmd>SudaRead<CR>", "Sudo read" },
            S = { "<cmd>SudaWrite<CR>", "Sudo write" },
            y = { "<cmd>let @+ = expand('%:p')<CR>", "Yank file path" },
            Y = { "<cmd>let @+ = expand('%:~:.')<CR>", "Yank file path from project" },
            -- D = { "<cmd>lua require('util').confirm('Delete this file?', print('hi'))<CR>", "Delete this file" }
          },
          g = {
            name = "Git",
            b = { "<cmd>lua require('neogit').open({'branch'})<CR>", "Open branch popup" },
            D = { "<cmd>GDelete<CR>", "Delete current file from git" },
            f = { "<cmd>G fetch<CR>", "Fetch" },
            o = { "<cmd>GBrowse<CR>", "Open in browser" },
            g = {
              "<cmd>lua require('toggleterm.terminal').Terminal:new({cmd = 'lazygit', direction = 'float'}):toggle()<CR>",
              "Lazygit",
            },
            y = {
              "<cmd>lua require('gitlinker').get_buf_range_url('n')<CR>",
              "Yank link to current line",
            },
          },
          h = {
            name = "Hunk",
            b = { "<cmd>Gitsigns blame_line<CR>", "Blame line" },
            n = { "<cmd>Gitsigns next_hunk<CR>", "Next hunk" },
            p = { "<cmd>Gitsigns prev_hunk<CR>", "Previous hunk" },
            P = { "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
            s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage current hunk" },
            S = { "<cmd>Gitsigns stage_buffer<CR>", "Stage current buffer" },
            r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset current hunk" },
            R = { "<cmd>Gitsigns reset_buffer<CR>", "Reset current buffer" },
            u = { "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" },
            U = { "<cmd>Gitsigns reset_buffer_index<CR>", "Reset buffer index" },
          },
          p = {
            name = "Projects",
            p = { "<cmd>:Telescope projects<CR>", "Switch Project" },
          },
          o = {
            name = "Open",
            t = { "<cmd>ToggleTerm<CR>", "Terminal" },
            D = {
              "<cmd>lua require('toggleterm.terminal').Terminal:new({cmd = 'lazydocker', direction = 'float'}):toggle()<CR>",
              "Docker",
            },
            r = { "<cmd>RnvimrToggle<CR>", "Ranger" },
          },
          ["<space>"] = {
            "<cmd>lua if not pcall(require('telescope.builtin').git_files, {}) then require('telescope.builtin').find_files() end<CR>",
            "Find file in project",
          },
          [","] = { "<cmd>Telescope buffers<CR>", "Switch buffer" },
          ["."] = { "<cmd>Telescope file_browser<CR>", "Find file" },
          ["/"] = { "<cmd>Telescope live_grep<CR>", "Search in project" },
        }

        local visual_binds = {
          g = {
            y = {
              "<cmd>lua require('gitlinker').get_buf_range_url('v')<CR>",
              "Yank link to current selection",
            },
          },
        }

        if vim.fn.has("macos") then
          normal_binds.o.o = {
            string.format("<cmd>silent !open -a Finder.app %s<CR>", vim.fn.expand("%:p:h")),
            "Open directory in Finder",
          }
        end

        whichkey.register(normal_binds, { prefix = "<leader>" })
        whichkey.register(vim.tbl_deep_extend("force", normal_binds, visual_binds), { prefix = "<leader>", mode = "v" })
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
        if not vim.g.telescope_loaded then
          local actions = require("telescope.actions")
          require("telescope").setup({
            defaults = {
              mappings = {
                i = {
                  ["<esc>"] = actions.close,
                },
              },
            },
          })
          require("project_nvim").setup({})
          require("telescope").load_extension("projects")
          require("telescope").load_extension("neoclip")
          vim.g.telescope_loaded = true
        end
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
        if vim.fn.has("macos") then
          require("nvim-treesitter.install").compilers = { "gcc-11" }
        end

        -- Extra parser configs
        local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
        parser_configs.haskell = {
          install_info = {
            url = "https://github.com/tree-sitter/tree-sitter-haskell",
            files = { "src/parser.c", "src/scanner.cc" },
          },
          filetype = "haskell",
        }
        parser_configs.markdown = {
          install_info = {
            url = "https://github.com/ikatyang/tree-sitter-markdown",
            files = { "src/parser.c", "src/scanner.cc" },
          },
          filetype = "markdown",
        }

        parser_configs.org = {
          install_info = {
            url = "https://github.com/milisims/tree-sitter-org",
            revision = "main",
            files = { "src/parser.c", "src/scanner.cc" },
          },
          filetype = "org",
        }

        -- Main treesitter config
        require("nvim-treesitter.configs").setup({
          ensure_installed = "all",
          additional_vim_regex_highlighting = { "org" },

          highlight = {
            enable = true,
          },

          incremental_selection = {
            enable = true,

            keymaps = {
              init_selection = "gnn",
              node_incremental = "gnn",
              scope_incremental = "gns",
              node_decremental = "gnp",
            },
          },

          indent = { enable = true },

          textsubjects = {
            enable = true,
            keymaps = { [","] = "textsubjects-smart" },
          },

          autopairs = { enable = true },

          textobjects = {
            select = {
              enable = true,
              keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["icd"] = "@conditional.inner",
                ["acd"] = "@conditional.outer",
                ["acm"] = "@comment.outer",
                ["ilp"] = "@loop.inner",
                ["alp"] = "@loop.outer",
                ["ast"] = "@statement.outer",
                ["isc"] = "@scopename.inner",
                ["iB"] = "@block.inner",
                ["aB"] = "@block.outer",
                ["p"] = "@parameter.inner",
              },
            },

            move = {
              enable = true,
              set_jumps = true, -- Whether to set jumps in the jumplist
              goto_next_start = {
                ["gnf"] = "@function.outer",
                ["gnif"] = "@function.inner",
                ["gnp"] = "@parameter.inner",
                ["gnc"] = "@call.outer",
                ["gnic"] = "@call.inner",
              },
              goto_next_end = {
                ["gnF"] = "@function.outer",
                ["gniF"] = "@function.inner",
                ["gnP"] = "@parameter.inner",
                ["gnC"] = "@call.outer",
                ["gniC"] = "@call.inner",
              },
              goto_previous_start = {
                ["gpf"] = "@function.outer",
                ["gpif"] = "@function.inner",
                ["gpp"] = "@parameter.inner",
                ["gpc"] = "@call.outer",
                ["gpic"] = "@call.inner",
              },
              goto_previous_end = {
                ["gpF"] = "@function.outer",
                ["gpiF"] = "@function.inner",
                ["gpP"] = "@parameter.inner",
                ["gpC"] = "@call.outer",
                ["gpiC"] = "@call.inner",
              },
            },
          },

          playground = {
            enable = true,
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
            keybindings = {
              toggle_query_editor = "o",
              toggle_hl_groups = "i",
              toggle_injected_languages = "t",
              toggle_anonymous_nodes = "a",
              toggle_language_display = "I",
              focus_language = "f",
              unfocus_language = "F",
              update = "R",
              goto_node = "<cr>",
              show_help = "?",
            },
          },

          rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = 1000,
            colors = {
              "#bf616a",
              "#d08770",
              "#ebcb8b",
              "#a3be8c",
              "#88c0d0",
              "#5e81ac",
              "#b48ead",
            },
          },
          tree_docs = { enable = true },

          context_commentstring = { enable = true },

          refactor = {
            highlight_definitions = { enable = true },
            smart_rename = {
              enable = true,
              keymaps = {
                smart_rename = "gR",
              },
            },
          },
        })
      end,
      requires = {
        "RRethy/nvim-treesitter-textsubjects", -- Location & syntax-aware text objects
        "nvim-treesitter/nvim-treesitter-textobjects", -- Custom objects using treesitter
        "nvim-treesitter/nvim-treesitter-refactor", -- Slightly better refactorings
        "JoosepAlviste/nvim-ts-context-commentstring", -- Correctly guess which comment to use in a mixed-mode file
        "p00f/nvim-ts-rainbow", -- 🌈
        "spywhere/detect-language.nvim", -- Whose ls is it anyway?
      },
    })

    -- TODO Set this up
    -- use {
    --     "nvim-treesitter/nvim-tree-docs",
    --     requires = {
    --         {"nvim-treesitter/nvim-treesitter"},
    --     },
    -- }

    -- Debug tool for treesitter
    use({
      "nvim-treesitter/playground",
      cmd = "TSPlaygroundToggle",
    })

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
          shade_terminals = false,
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
        vim.g.dap_virtual_text = true
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
        local whichkey = require("which-key")
        function TelescopeCodeActions()
          local opts = {
            winblend = 15,
            layout_config = {
              prompt_position = "top",
              width = 80,
              height = 12,
            },
            borderchars = {
              prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
              results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
              preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            },
            border = {},
            previewer = false,
            shorten_path = false,
          }
          require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_dropdown(opts))
        end

        -- Borrowed from https://github.com/kabouzeid/nvim-lspinstall/wiki
        -- keymaps
        local on_attach = function(client, bufnr)
          require("lsp_signature").on_attach({
            bind = true,
            handler_opts = {
              border = "single",
            },
          }, bufnr)
          local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
          end

          vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
          vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
          buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

          -- Mappings
          local opts = { noremap = true, silent = true, buffer = bufnr }
          whichkey.register({
            K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show documentation for symbol" },
            g = {
              d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "LSP definition" },
              D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "LSP declaration" },
              i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "LSP implementation" },
              r = { "<cmd>lua vim.lsp.buf.references()<CR>", "LSP references" },
            },
            ["<leader>"] = {
              c = {
                name = "Code",
                a = { "<cmd>lua TelescopeCodeActions()<CR>", "LSP Code Actions" },
                c = { "<cmd>Make<CR>", "Compile" },
                w = {
                  name = "Workspaces",
                  a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add workspace folder" },
                  r = {
                    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
                    "Remove workspace folder",
                  },
                  l = {
                    "<cmd> lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                    "List workspace folders",
                  },
                },
                x = {
                  "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = 'single'})<CR>",
                  "Show diagnostics for line",
                },
              },
              ["["] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Jump to previous error" },
              ["]"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Jump to next error" },
            },
          }, opts)

          -- Set some keybinds conditional on server capabilities
          if client.resolved_capabilities.document_formatting then
            whichkey.register({
              ["<leader>cf"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format buffer" },
            }, opts)
          elseif client.resolved_capabilities.document_range_formatting then
            whichkey.register({
              ["<leader>cf"] = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format buffer/region" },
            }, opts)
          end

          -- Set autocommands conditional on server_capabilities
          if client.resolved_capabilities.document_highlight then
            vim.api.nvim_exec(
              [[
                    augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                    augroup END
                        ]],
              false
            )
          end
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

        -- Include rtp for nvim
        local runtime_path = vim.split(package.path, ";")
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")

        -- Configure lua language server for neovim development
        local lua_settings = {
          filetypes = { "lua" },
          Lua = {
            runtime = {
              -- LuaJIT in the case of Neovim
              version = "LuaJIT",
              path = runtime_path,
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
        }

        local lsp_installer = require("nvim-lsp-installer")
        lsp_installer.on_server_ready(function(server)
          local config = {
            capabilities = capabilities,
            on_attach = on_attach,
          }

          if server.name == "sumneko_lua" then
            config.settings = lua_settings
          end

          server:setup(config)
          vim.cmd("do User LspAttachBuffers")
        end)
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
        require("lspkind").init()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        cmp.setup({
          sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "path" },
            { name = "buffer" },
            { name = "luasnip" },
            { name = "orgmode" },
          },
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          mapping = {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-g>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
            ["<Tab>"] = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end,
            ["<S-Tab>"] = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end,
          },
          formatting = {
            format = require("lspkind").cmp_format({ with_text = false, maxwidth = 50 }),
          },
          documentation = {
            border = "single",
          },
        })
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
      },
    })

    -- Faster-than-light jumping
    use("ggandor/lightspeed.nvim")

    -- Automatic pair matching
    use("LunarWatcher/auto-pairs")

    -- Async Lint Engine
    use({
      "dense-analysis/ale",
      config = function()
        -- vim.g.ale_fix_on_save = 1
      end,
      rocks = { "luaformatter", server = "https://luarocks.org/dev" },
    })

    -- Telescope most recently used
    use({
      "nvim-telescope/telescope-frecency.nvim",
      config = function()
        require("telescope").load_extension("frecency")
      end,
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
      config = function()
        require("neoclip").setup({
          enable_persistant_history = true,
        })
      end,
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
    use({ "mrjones2014/dash.nvim", requires = { "nvim-telescope/telescope.nvim" }, run = "make install" })
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
