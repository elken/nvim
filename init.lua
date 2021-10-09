-- General config
--
-- Help documentation can be viewed with `:h <property>`
local fn = vim.fn
-- TODO Use this, if needed
-- local colors = require('nord.colors')

-- Only run these settings once
if not packer_plugins then
    vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
    vim.opt.termguicolors = true
end

vim.g.did_load_filetypes = 1
vim.g.formatoptions = 'qrn1'
vim.opt.guifont = "Iosevka Nerd Font Mono"
vim.opt.showmode = false
vim.opt.timeoutlen = 500
vim.opt.updatetime = 100
vim.wo.signcolumn = 'yes'
vim.opt.scrolloff = 5
vim.opt.wrap = false
vim.opt.laststatus = 2
vim.opt.ttimeoutlen = 5
vim.opt.virtualedit = "block"
vim.opt.undodir = "~/.config/nvim/undo"
vim.opt.shell = '/bin/zsh'

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

-- Completion
vim.opt.completeopt = "menuone,noselect"

-- Jump to last line when opening a file
vim.cmd[[
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif
]]

-- Run PackerCompile after saving init.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])

-- Firenvim buffers
vim.cmd[[
    au BufEnter github.com_*.txt set filetype=markdown
    au BufEnter reddit.com_*.txt set filetype=markdown
]]

-- Change directory to the current buffer
vim.cmd[[
    autocmd BufEnter * silent! lcd %:p:h
]]

-- Make containing directory if missing
vim.cmd[[
    autocmd BufWritePre * silent! Mkdir
]]

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Installed packer if it's missing
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    vim.cmd([[
          autocmd VimEnter * PackerSync
    ]])
end

-- Fancy borders for LSP
local float_borders = {
      {"🭽", "FloatBorder"},
      {"▔", "FloatBorder"},
      {"🭾", "FloatBorder"},
      {"▕", "FloatBorder"},
      {"🭿", "FloatBorder"},
      {"▁", "FloatBorder"},
      {"🭼", "FloatBorder"},
      {"▏", "FloatBorder"},
}

return require('packer').startup({function(use)
    -- Packer (needed to manage packer packages to manage packages to manage...)
    use "wbthomason/packer.nvim"

    -- Most important package; the colour scheme
    use {
        "shaunsingh/nord.nvim",
        config = function ()
            vim.g.nord_contrast = true
            vim.g.nord_borders = true

            if not vim.g.colourscheme_set then
                vim.cmd([[colorscheme nord]])
                vim.g.colourscheme_set = true
            end
        end,
        requires = "folke/lsp-colors.nvim"
    }

    -- Add fancy indent markers, which integrate nicely with treesitter
    -- and shows the current context
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            require("indent_blankline").setup({
                filetype_exclude = {
                    "startify", "dashboard", "dotooagenda", "log", "fugitive", "gitcommit",
                    "packer", "vimwiki", "markdown", "json", "txt", "vista", "help",
                    "todoist", "NvimTree", "peekaboo", "git", "TelescopePrompt", "undotree",
                    "flutterToolsOutline", "" -- for all buffers without a file type
                },
                buftype_exclude = {"help", "terminal", "nofile"},
                use_treesitter = true,
                show_current_context = true,
                max_indent_increase = 1
            })
        end
    }

    -- Pointless rice project; the statusline. Pick a nice one that works
    -- ootb and leave it there.
    use {
        "shadmansaleh/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    theme = "nord",
                    section_separators = {left = '', right = ''},
                    component_separators = {left = '╲', right = '╱'}
                },
                sections = {
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,
                            path = 1
                        }
                    }
                }
            })
        end,
        requires = "kyazdani42/nvim-web-devicons"
    }

    -- Which key is that? Which-key!
    use {
        "folke/which-key.nvim",
        config = function()
            local whichkey = require("which-key")
            whichkey.setup {
                plugins = {
                    spelling = {
                        enabled = true
                    }
                }
            }

            local binds = {
                b = {
                    name = "Buffer",
                    d = { "<cmd>bdelete<CR>", "Kill buffer" },
                    p = { "<cmd>bp<CR>", "Previous buffer" },
                    n = { "<cmd>bn<CR>", "Next buffer" },
                },
                f = {
                    name = "File",
                    f = { "<cmd>lua if not pcall(require('telescope.builtin').git_files, {}) then require('telescope.builtin').find_files() end<CR>", "Find file in project"},
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
                    h = {
                        name = "Hunk",
                        b = { "<cmd>Gitsigns blame_line<CR>", "Blame line" },
                        n = { "<cmd>Gitsigns next_hunk<CR>", "Next hunk" },
                        p = { "<cmd>Gitsigns prev_hunk<CR>", "Previous hunk" },
                        s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage current hunk" },
                        r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset current hunk"}
                    },
                    b = { "<cmd>lua require('neogit').open({'branch'})<CR>", "Open branch popup" },
                    D = { "<cmd>GDelete<CR>", "Delete current file from git" },
                    f = { "<cmd>G fetch<CR>", "Fetch" },
                    o = { "<cmd>GBrowse<CR>", "Open in browser" },
                    g = { "<cmd>lua require('toggleterm.terminal').Terminal:new({cmd = 'lazygit', direction = 'float'}):toggle()<CR>", "Lazygit" }
                },
                h = "which_key_ignore",
                o = {
                    name = "Open",
                    t = { "<cmd>ToggleTerm<CR>", "Terminal" },
                    D = { "<cmd>lua require('toggleterm.terminal').Terminal:new({cmd = 'lazydocker', direction = 'float'}):toggle()<CR>", "Docker" },
                    r = { "<cmd>RnvimrToggle<CR>", "Ranger" },
                },
                ["<space>"] = { "<cmd>lua if not pcall(require('telescope.builtin').git_files, {}) then require('telescope.builtin').find_files() end<CR>", "Find file in project" },
                [","] = { "<cmd>Telescope buffers<CR>", "Switch buffer" },
                ["."] = { "<cmd>Telescope file_browser<CR>", "Find file" },
                ["/"] = { "<cmd>Telescope live_grep<CR>", "Search in project" },
            }


            if vim.fn.has('macos') then
                binds.o.o = { string.format("<cmd>silent !open -a Finder.app %s<CR>", vim.fn.expand('%:p:h')), "Open directory in Finder" }
            end

            whichkey.register(binds, { prefix = "<leader>" })
        end
    }

    -- Highlight colours (sometimes, currently)
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    }

    -- The big daddy
    use {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        module = "telescope",
        config = function ()
            local actions = require('telescope.actions')
            require('telescope').setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close
                        },
                    },
                }
            })
        end,
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim"
        }
    }

    -- Project management
    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({})
            require("telescope").load_extension("projects")
        end,
        requires = "nvim-telescope/telescope.nvim"
    }

    -- 􏿽
    use 'chrisbra/unicode.vim'

    -- :w !sudo tee % > /dev/null
    use {
        'lambdalisue/suda.vim',
        cmd = { "SudaWrite", "SudaRead" }
    }

    -- Comment all the things
    use 'tpope/vim-commentary'

    -- Add "end" in ruby, lua, etc
    use 'tpope/vim-endwise'

    -- Unix helpers
    use 'tpope/vim-eunuch'

    -- The git plugin so good, it should be illegal
    use 'tpope/vim-fugitive'

    -- Enable repeating supported plugin maps with "."
    use 'tpope/vim-repeat'

    -- GitHub extension for fugitive.vim
    use 'tpope/vim-rhubarb'

    -- Increment dates/times
    use 'tpope/vim-speeddating'

    --  Quoting/parenthesizing made simple
    use 'tpope/vim-surround'

    -- Pretty good test runner
    use {
        "rcarriga/vim-ultest",
        run = ":UpdateRemotePlugins",
        requires = "vim-test/vim-test"
    }

    -- Syntax and speed
    -- Sitting in a tree
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function ()
            if vim.fn.has('macos') then
                require('nvim-treesitter.install').compilers = { "gcc-11" }
            end

            -- Extra parser configs
            local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
            parser_configs.haskell = {
                install_info = {
                    url = "https://github.com/tree-sitter/tree-sitter-haskell",
                    files = {"src/parser.c", "src/scanner.cc"}
                },
                filetype = "haskell"
            }
            parser_configs.markdown = {
                install_info = {
                    url = "https://github.com/ikatyang/tree-sitter-markdown",
                    files = {"src/parser.c", "src/scanner.cc"}
                },
                filetype = "markdown"
            }

            -- Main treesitter config
            require('nvim-treesitter.configs').setup {
                ensure_installed = "all",

                highlight = {
                    enable = true
                },

                incremental_selection = {
                    enable = true,

                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "gnn",
                        scope_incremental = "gns",
                        node_decremental = "gnp"
                    }
                },

                indent = {enable = true},

                textsubjects = {
                    enable = true,
                    keymaps = {[','] = 'textsubjects-smart'}
                },

                autopairs = {enable = true},

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
                            ["p"] = "@parameter.inner"
                        }
                    },

                    move = {
                        enable = true,
                        set_jumps = true, -- Whether to set jumps in the jumplist
                        goto_next_start = {
                            ["gnf"] = "@function.outer",
                            ["gnif"] = "@function.inner",
                            ["gnp"] = "@parameter.inner",
                            ["gnc"] = "@call.outer",
                            ["gnic"] = "@call.inner"
                        },
                        goto_next_end = {
                            ["gnF"] = "@function.outer",
                            ["gniF"] = "@function.inner",
                            ["gnP"] = "@parameter.inner",
                            ["gnC"] = "@call.outer",
                            ["gniC"] = "@call.inner"
                        },
                        goto_previous_start = {
                            ["gpf"] = "@function.outer",
                            ["gpif"] = "@function.inner",
                            ["gpp"] = "@parameter.inner",
                            ["gpc"] = "@call.outer",
                            ["gpic"] = "@call.inner"
                        },
                        goto_previous_end = {
                            ["gpF"] = "@function.outer",
                            ["gpiF"] = "@function.inner",
                            ["gpP"] = "@parameter.inner",
                            ["gpC"] = "@call.outer",
                            ["gpiC"] = "@call.inner"
                        }
                    }
                },

                playground = {
                    enable = true,
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?'
                    }
                },

                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = 1000,
                    colors = {
                        '#bf616a',
                        '#d08770',
                        '#ebcb8b',
                        '#a3be8c',
                        '#88c0d0',
                        '#5e81ac',
                        '#b48ead'
                    }
                },
                tree_docs = {enable = true},

                context_commentstring = {enable = true}
            }
        end,
        requires = {
            "RRethy/nvim-treesitter-textsubjects",           -- Location & syntax-aware text objects
            "nvim-treesitter/nvim-treesitter-textobjects",   -- Custom objects using treesitter
            "JoosepAlviste/nvim-ts-context-commentstring",   -- Correctly guess which comment to use in a mixed-mode file
            "p00f/nvim-ts-rainbow"                           -- 🌈
        }
    }

    -- TODO Set this up
    -- use {
    --     "nvim-treesitter/nvim-tree-docs",
    --     requires = {
    --         {"nvim-treesitter/nvim-treesitter"},
    --     },
    -- }

    -- Debug tool for treesitter
    use {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle"
    }

    -- Neovim anywhere
    -- TODO Refine this (remove barbar etc)
    use {
        "glacambre/firenvim",
        run = function()
            vim.fn["firenvim#install"](0)
        end
    }

    -- Git changes in the gutter
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end,
        requires = "nvim-lua/plenary.nvim"
    }

    -- Markdown preview
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        config = function()
            vim.g.mkdp_browser = "firefox"
        end
    }

    -- WIP Magit
    -- Not good enough yet, but getting there
    use {
        "TimUntersberger/neogit",
        config = function ()
            require('neogit').setup({
                integrations = {
                    diffview = true
                }
            })
        end,
        requires = {
            "sindrets/diffview.nvim",
            'nvim-lua/plenary.nvim'
        }
    }

    -- WIP orgmode
    -- Not good enough yet, but getting there
    use {
        'kristijanhusak/orgmode.nvim',
        config = function()
            require('orgmode').setup({})
        end
    }

    -- Github integration (making issues etc)
    use {
        "pwntester/octo.nvim",
        cmd = "Octo",
        config = function()
            require("octo").setup({
                default_remote = {"upstream", "elken", "origin"}
            })
        end
    }

    -- Toggleable terminal buffer
    use {
        "akinsho/nvim-toggleterm.lua",
        config = function()
            require("toggleterm").setup({
                direction = "horizontal",
                shell = vim.o.shell, -- change the default shell
                float_opts = {
                    -- The border key is *almost* the same as 'nvim_win_open'
                    -- see :h nvim_win_open for details on borders however
                    -- the 'curved' border is a custom border type
                    -- not natively supported but implemented in this plugin.
                    border = "double",
                    winblend = 0,
                    highlights = {border = "Normal", background = "Normal"}
                }
            })

            -- Easier escape from terminal buffers
            vim.api.nvim_set_keymap('t', '<C-]>', '<C-\\><C-n>', { noremap = true, silent = true })
        end
    }

    -- Tab bar plugin
    -- TODO Hide this in firenvim
    use {
        "akinsho/bufferline.nvim",
        config = function ()
            require('bufferline').setup({
                options = {
                    diagnostics = "nvim_lsp",
                    separator_style = "slant",
                    always_show_bufferline = false
                }
            })
        end,
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- Better QuickFix
    use "kevinhwang91/nvim-bqf"

    -- Main DAP plugin
    -- TODO Get DAP setup neatly
    use {"mfussenegger/nvim-dap", module = "dap"}

    -- UI for above
    use {"rcarriga/nvim-dap-ui", after = "nvim-dap"}

    -- EZ installer for DAP servers
    use {
        "Pocco81/DAPInstall.nvim",
        config = function()
            local dap = require('dap-install')

            local debugger_list =
                require('dap-install.debuggers_list').debuggers

            for debugger, _ in pairs(debugger_list) do
                dap.config(debugger, {})
            end
        end,
        cmd = {"DIInstall", "DIUninstall", "DIList"},
    }

    -- Fancy IDE stuff
    use {
        "kabouzeid/nvim-lspinstall",
        config = function ()
            local whichkey = require('which-key')
            function TelescopeCodeActions()
                local theme = require('telescope.themes').get_ivy()
                theme['layout_config']['height'] = 10
                require('telescope.builtin').lsp_code_actions(theme)
            end

            -- Borrowed from https://github.com/kabouzeid/nvim-lspinstall/wiki
            -- keymaps
            local on_attach = function(client, bufnr)
                require "lsp_signature".on_attach({
                    bind = true,
                    handler_opts = {
                        border = "single"
                    }
                }, bufnr)
                local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

                vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "single"})
                vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = float_borders})
                buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings
                local opts = { noremap=true, silent=true, buffer = bufnr }
                whichkey.register({
                    K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show documentation for symbol" },
                    g = {
                        d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "LSP definition" },
                        D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "LSP declaration" },
                        i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "LSP implementation" },
                        r = { "<cmd>lua vim.lsp.buf.references()<CR>", "LSP references" },
                        R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "LSP rename" },
                    },
                    ["<leader>"] = {
                        c = {
                            name = "Code",
                            a = { "<cmd>lua TelescopeCodeActions()<CR>", "LSP Code Actions" },
                            c = { "<cmd>Make<CR>", "Compile" },
                            w = {
                                name = "Workspaces",
                                a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add workspace folder" },
                                r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove workspace folder" },
                                l = { "<cmd> lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List workspace folders" }
                            },
                            x = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = 'single'})<CR>", "Show diagnostics for line" }
                        },
                        ["["] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Jump to previous error" },
                        ["]"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Jump to next error" },
                    }
                }, opts)

                -- Set some keybinds conditional on server capabilities
                if client.resolved_capabilities.document_formatting then
                    whichkey.register({
                        ["<leader>cf"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format buffer" }
                    }, opts)
                elseif client.resolved_capabilities.document_range_formatting then
                    whichkey.register({
                        ["<leader>cf"] = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format buffer/region" }
                    }, opts)
                end

                -- Set autocommands conditional on server_capabilities
                if client.resolved_capabilities.document_highlight then
                    vim.api.nvim_exec([[
                    augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                    augroup END
                        ]], false)
                end
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

            -- Configure lua language server for neovim development
            local lua_settings = {
                filetypes = {"lua"},
                Lua = {
                    runtime = {
                        -- LuaJIT in the case of Neovim
                        version = 'LuaJIT',
                        path = vim.split(package.path, ';'),
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {'vim'},
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file('', true),
                    },
                }
            }

            local function setup_servers()
                require'lspinstall'.setup()
                local servers = require'lspinstall'.installed_servers()

                for _, server in pairs(servers) do
                    local config = {
                        capabilities = capabilities,
                        on_attach = on_attach,
                    }

                    -- language specific config
                    if server == "lua" then
                        config.settings = lua_settings
                    end

                    require'lspconfig'[server].setup(config)
                end
            end

            setup_servers()

            -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
            require'lspinstall'.post_install_hook = function ()
                setup_servers() -- reload installed servers
                vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
            end
        end,
        after = "which-key.nvim",
        requires ={
            "neovim/nvim-lspconfig",
            "ray-x/lsp_signature.nvim"
        }
    }

    -- Completion framework
    -- TODO Customize the new popup window
    use {
        "hrsh7th/nvim-cmp",
        config = function()
            require('lspkind').init()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            cmp.setup {
                sources = {
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "buffer" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                    { name = "orgmode" },
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-g>'] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ['<Tab>'] = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
                        else
                            fallback()
                        end
                    end,
                    ['<S-Tab>'] = function(fallback)
                        if cmp.visible() then
                        elseif luasnip.jumpable(-1) then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
                        else
                            fallback()
                        end
                    end,
                },
                formatting = {
                    format = function(entry, vim_item)
                        -- fancy icons and a name of kind
                        vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

                        -- set a name for each source
                        vim_item.menu = ({
                            path = "[Path]",
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[Latex]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                documentation = {
                    border = float_borders;
                }
            }
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
        }
    }

    -- Faster-than-light jumping
    use "ggandor/lightspeed.nvim"

    -- Automatic pair matching
    use {
        "windwp/nvim-autopairs",
        config = function ()
            require("nvim-autopairs").setup()
            require("nvim-autopairs.completion.cmp").setup({
                map_cr = true, --  map <CR> on insert mode
                map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
            })
        end,
        after = "nvim-cmp"
    }

    -- Async Lint Engine
    use {
        "dense-analysis/ale",
        config = function ()
            vim.g.ale_fix_on_save = 1
        end,
        rocks = { 'luaformatter', server = 'https://luarocks.org/dev' }
    }

    -- Telescope most recently used
    use {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require"telescope".load_extension("frecency")
        end,
        requires = {"tami5/sqlite.lua"}
    }

    -- Simple popup notification library
    use {
        "rcarriga/nvim-notify",
        config = function ()
            vim.notify = require('notify')
        end
    }

    -- Free real estate for startup perf
    use "nathom/filetype.nvim"

    -- File browser (depends on ranger)
    use "kevinhwang91/rnvimr"
end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float { border = "rounded" }
            end,
        }
}})
