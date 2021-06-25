local fn = vim.fn

-- Installed packer if it's missing
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
end

return require('packer').startup(function(use)
    use {
	'NTBBloodbath/doom-one.nvim',
	config = function()
	    vim.cmd("colorscheme doom-one")
	end
    }

    use "wbthomason/packer.nvim"
    use 'neomake/neomake'
    use 'chrisbra/unicode.vim'
    use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
    use 'lambdalisue/suda.vim'
    use 'tpope/vim-endwise'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-repeat'
    use 'tpope/vim-speeddating'
    use 'tpope/vim-vinegar'
    use 'sindrets/diffview.nvim'

    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() require 'elken-galaxyline' end,
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
	config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = "all",

                highlight = {enable = true},

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

            local parser_configs =
                require("nvim-treesitter.parsers").get_parser_configs()
            parser_configs.markdown = {
                install_info = {
                    url = "https://github.com/ikatyang/tree-sitter-markdown",
                    files = {"src/parser.c", "src/scanner.cc"}
                },
                filetype = "markdown"
            }
        end
    }

    use {"RRethy/nvim-treesitter-textsubjects", requires = {"nvim-treesitter"}}

    use {
        "nvim-treesitter/nvim-treesitter-textobjects",
        requires = {"nvim-treesitter"}
    }

    use {
        "JoosepAlviste/nvim-ts-context-commentstring",
        requires = {"nvim-treesitter"}
    }

    use {
        "nvim-treesitter/nvim-tree-docs",
        requires = {
	    {"nvim-treesitter/nvim-treesitter"},
	    {"Olical/aniseed", after = "nvim-treesitter"}
	},
    }

    use {
	"p00f/nvim-ts-rainbow",
	requires = {"nvim-treesitter"}
    }

    use {"nvim-treesitter/playground", cmd = "TSPlaygroundToggle"}

    use {
        "glacambre/firenvim",
        run = function()
	    vim.fn["firenvim#install"](0)
	end
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end
    }

    use {
        "windwp/nvim-autopairs",
        config = function()
            require('nvim-autopairs').setup {check_ts = true}
        end,
	after = 'nvim-treesitter'
    }

    use "monaqa/dial.nvim"

    use {
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function() require('gitsigns').setup() end
    }

    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        config = function() vim.g.mkdp_browser = "firefox" end
    }

    use {
        "mizlan/iswap.nvim",
        requires = {"nvim-treesitter"},
        config = function()
            require('iswap').setup {
                -- The keys that will be used as a selection, in order
                -- ('asdfghjklqwertyuiopzxcvbnm' by default)
                keys = 'ashtgyneoi',

                -- Grey out the rest of the text when making a selection
                -- (enabled by default)
                grey = 'disable',

                -- Highlight group for the sniping value (asdf etc.)
                -- default 'Search'
                hl_snipe = 'Search',

                -- Highlight group for the visual selection of terms
                -- default 'Visual'
                hl_selection = 'Visual',

                -- Highlight group for the greyed background
                -- default 'Comment'
                hl_grey = 'Comment'
            }
        end
    }

    use {"TimUntersberger/neogit", cmd = "Neogit"}

    use {
        'vhyrro/neorg',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {}, -- Load all the default modules
                    ["core.norg.concealer"] = {} -- Enhances the text editing experience by using icons
                }
            }
        end
    }

    use {
        "karb94/neoscroll.nvim",
        config = function() require('neoscroll').setup() end
    }

    use {
        "pwntester/octo.nvim",
        cmd = "Octo",
        config = function() require('octo').setup() end
    }

    use {"glepnir/prodoc.nvim", cmd = "ProDoc"}

    use {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        module = "telescope",
        requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"}
    }

    use {
        "akinsho/nvim-toggleterm.lua",
        module = "toggleterm.terminal",
        config = function()
            require('toggleterm').setup {
                size = 90,
                open_mapping = nil,
                hide_numbers = true, -- hide the number column in toggleterm buffers
                start_in_insert = false,
                persist_size = true,
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

    use "romgrk/barbar.nvim"

    use "kevinhwang91/nvim-bqf"

    use {
        "jghauser/mkdir.nvim",
        config = function() require('mkdir') end,
        event = "BufWritePre"
    }

    use {"mfussenegger/nvim-dap", module = "dap"}

    use {"rcarriga/nvim-dap-ui", after = "nvim-dap"}

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

    use {
        "lukas-reineke/format.nvim",
        config = function()
            require('format').setup {
                ["*"] = {
                    {cmd = {"sed -i 's/[ \t]*$//'"}} -- Removes trailing whitespace
                },
                lua = {{cmd = {"lua-format"}}},
                go = {
                    {
                        cmd = {"gofmt -w", "goimports -w"},
                        tempfile_postfix = ".tmp"
                    }
                },
                javascript = {
                    {cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}
                },
                markdown = {
                    {cmd = {"prettier -w"}}, {
                        cmd = {"black"},
                        start_pattern = "^```python$",
                        end_pattern = "^```$",
                        target = "current"
                    }
                }
            }
        end,
        cmd = {"Format", "FormatWrite"},
	--rocks = {'luaformatter', server = 'https://luarocks.org/dev'}
    }

    use "neovim/nvim-lspconfig"

    use {
        "kabouzeid/nvim-lspinstall",
        config = function()
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
		  library = {
		    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
		    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
		  },
		},
	      }
	    }

	    -- config that activates keymaps and enables snippet support
	    local function make_config()
	      local capabilities = vim.lsp.protocol.make_client_capabilities()
	      capabilities.textDocument.completion.completionItem.snippetSupport = true
	      return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
	      }
	    end

	    -- lsp-install
	    local function setup_servers()
	      require'lspinstall'.setup()

	      -- get all installed servers
	      local servers = require'lspinstall'.installed_servers()

	      for _, server in pairs(servers) do
		local config = make_config()

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
        requires = {"nvim-lspconfig"},
    }

    use {
        "hrsh7th/nvim-compe",
        config = function()
	    local t = function(str)
	      return vim.api.nvim_replace_termcodes(str, true, true, true)
	    end

	    local check_back_space = function()
		local col = vim.fn.col('.') - 1
		if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		    return true
		else
		    return false
		end
	    end

	    -- Use (s-)tab to:
	    --- move to prev/next item in completion menuone
	    --- jump to prev/next snippet's placeholder
	    _G.tab_complete = function()
	      if vim.fn.pumvisible() == 1 then
		return t "<C-n>"
	      elseif vim.fn.call("vsnip#available", {1}) == 1 then
		return t "<Plug>(vsnip-expand-or-jump)"
	      elseif check_back_space() then
		return t "<Tab>"
	      else
		return vim.fn['compe#complete']()
	      end
	    end
	    _G.s_tab_complete = function()
	      if vim.fn.pumvisible() == 1 then
		return t "<C-p>"
	      elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
		return t "<Plug>(vsnip-jump-prev)"
	      else
		-- If <S-Tab> is not working in your terminal, change it to <C-h>
		return t "<S-Tab>"
	      end
	    end

	    vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
	    vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
	    vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
	    vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

            require('compe').setup {
                enabled = true,
                autocomplete = true,
                debug = false,
                min_length = 1,
                preselect = 'enable',
                throttle_time = 80,
                source_timeout = 200,
                incomplete_delay = 400,
                max_abbr_width = 100,
                max_kind_width = 100,
                max_menu_width = 120,
                documentation = true,

                source = {
                    path = true,
                    buffer = true,
                    calc = true,
                    nvim_lsp = true,
                    nvim_lua = true,
                    tags = true,
                    luasnip = true,
                    treesitter = true
                }
            }
        end,
        requires = {"nvim-treesitter"}
    }

    use {
        'phaazon/hop.nvim',
        as = 'hop',
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup {keys = 'etovxqpdygfblzhckisuran'}
        end
    }

end)
