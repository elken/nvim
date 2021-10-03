-- General config
--
-- Help documentation can be viewed with `:h <property>`
local fn = vim.fn

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.formatoptions = 'qrn1'
vim.opt.guifont = "Iosevka Nerd Font Mono"
vim.opt.termguicolors = true
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
vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]], false)

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
    autocmd BufWritePre * silent! <cmd>Mkdir
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
end

return require('packer').startup(function(use)
    -- Packer (needed to manage packer packages to manage packages to manage...)
    use "wbthomason/packer.nvim"

    -- Most important package; the colour scheme
    use {
        "shaunsingh/nord.nvim",
        config = function ()
            vim.g.nord_contrast = true
            vim.g.nord_borders = true

            vim.cmd([[colorscheme nord]])
        end
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
                buftype_exclude = {"terminal", "nofile"},
                use_treesitter = true,
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
                    theme = "nord"
                }
            })
        end,
        requires = "kyazdani42/nvim-web-devicons"
    }

    -- TODO When we get to mappings https://github.com/folke/which-key.nvim#%EF%B8%8F-mappings
    -- Which key is that? Which-key!
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                plugins = {
                    spelling = {
                        enabled = true
                    }
                }
            }
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
            vim.api.nvim_set_keymap('n', '<leader><leader>', '<cmd>lua require("telescope.builtin").builtin({include_extensions=true})<CR>' ,{noremap=true, silent=true})
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
            require("toggleterm").setup {
                size = 90,
                hide_numbers = true, -- hide the number column in toggleterm buffers
                direction = "float",
                shell = vim.o.shell, -- change the default shell
                -- This field is only relevant if direction is set to 'float'
                float_opts = {
                    -- The border key is *almost* the same as 'nvim_win_open'
                    -- see :h nvim_win_open for details on borders however
                    -- the 'curved' border is a custom border type
                    -- not natively supported but implemented in this plugin.
                    border = "double",
                    winblend = 0,
                    highlights = {border = "Normal", background = "Normal"}
                }
            }
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

    -- Basic formatting
    -- TODO https://www.reddit.com/r/neovim/comments/jvisg5/lets_talk_formatting_again/
    use {
        "lukas-reineke/format.nvim",
        config = function()
            require('format').setup {
                ["*"] = {
                    {cmd = {"sed -i 's/[ \t]*$//'"}} -- Removes trailing whitespace
                },
                lua = {{cmd = {"lua-format"}}},
                php = {{cmd = {"phpcbf"}}},
            }
        end,
        cmd = {"Format", "FormatWrite"},
        rocks = { 'luaformatter', server = 'https://luarocks.org/dev' }
    }

    -- Fancy IDE stuff
    use {
        "kabouzeid/nvim-lspinstall",
        config = function ()
            -- Borrowed from https://github.com/kabouzeid/nvim-lspinstall/wiki
            -- keymaps
            local on_attach = function(client, bufnr)
                local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

                buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                local opts = { noremap=true, silent=true }
                buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
                buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
                buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
                buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
                buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
                buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
                buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
                vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

                -- Set some keybinds conditional on server capabilities
                if client.resolved_capabilities.document_formatting then
                    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
                elseif client.resolved_capabilities.document_range_formatting then
                    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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
        requires = "neovim/nvim-lspconfig"
    }

    -- Completion framework
    use {
        "hrsh7th/nvim-cmp",
        config = function()
            require('lspkind').init()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            cmp.setup {
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
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
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = function(fallback)
                        if vim.fn.pumvisible() == 1 then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
                        elseif luasnip.expand_or_jumpable() then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
                        else
                            fallback()
                        end
                    end,
                    ['<S-Tab>'] = function(fallback)
                        if vim.fn.pumvisible() == 1 then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
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
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[Latex]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            }
        end,
        requires = {"nvim-treesitter", "hrsh7th/cmp-nvim-lsp", "onsails/lspkind-nvim", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip"}
    }

    -- Faster-than-light jumping
    use 'ggandor/lightspeed.nvim'
end)
