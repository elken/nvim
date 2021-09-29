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
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 8
vim.opt.softtabstop = 4

-- Completion
vim.opt.completeopt = "menuone,noselect"

-- Jump to last line when opening a file
-- vim.cmd[[
-- 	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif
-- ]]

-- Run PackerCompile after saving init.lua
vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
    autocmd BufWritePost init.lua PackerSync
  augroup end
]],
  false
)

-- Firenvim buffers
vim.cmd[[
    au BufEnter github.com_*.txt set filetype=markdown
    au BufEnter reddit.com_*.txt set filetype=markdown
]]

-- Change directory to the current buffer
vim.cmd[[
    autocmd BufEnter * silent! lcd %:p:h
]]

-- Installed packer if it's missing
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
end

require('packer').startup(function(use)
    use "wbthomason/packer.nvim"
    use {
	'shaunsingh/nord.nvim',
	config = function()
	    vim.cmd("colorscheme nord")
	end
    }

    use 'neomake/neomake'
    use 'chrisbra/unicode.vim'
    use "lukas-reineke/indent-blankline.nvim"
    use 'lambdalisue/suda.vim'
    use 'tpope/vim-commentary'
    use 'tpope/vim-endwise'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-speeddating'
    use 'tpope/vim-surround'
    use 'tpope/vim-vinegar'
    use 'sindrets/diffview.nvim'
    use { "rcarriga/vim-ultest", requires = {"vim-test/vim-test"}, run = ":UpdateRemotePlugins" }

    use {
        'itchyny/lightline.vim',
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    -- When we get to mappings https://github.com/folke/which-key.nvim#%EF%B8%8F-mappings
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

    -- TODO Set this up
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

    use {
	"TimUntersberger/neogit",
	config = function()
	    require('neogit').setup({
		integrations = {
		    diffview = true
		}
	    })
	end,
	requires = {
	    'nvim-lua/plenary.nvim',
	    'sindrets/diffview.nvim'
	}
    }

    use {
	'kristijanhusak/orgmode.nvim',
	config = function()
	    require('orgmode').setup({})
	end
    }

    use {
        "karb94/neoscroll.nvim",
        config = function() require('neoscroll').setup() end
    }

    use {
        "pwntester/octo.nvim",
        cmd = "Octo",
        config = function()
	    require('octo').setup({
		default_remote = {"upstream", "elken", "origin"}
	    })
	end
    }

    use {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        module = "telescope",
        requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},
	config = function()
	    require('telescope').setup({
		pickers = {
		    find_files = {
			follow = true
		    }
		}
	    })
	end
    }

    use {
        "akinsho/nvim-toggleterm.lua",
        config = function()
            require('toggleterm').setup {
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
		php = {{cmd = {"phpcbf"}}},
            }
        end,
        cmd = {"Format", "FormatWrite"},
	--rocks = { 'luaformatter', server = 'https://luarocks.org/dev' }
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
	      capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
        "hrsh7th/nvim-cmp",
        config = function()
	    require('cmp').setup {
		sources = {
		    { name = "nvim_lsp" }
		},
	    }
        end,
        requires = {"nvim-treesitter", "hrsh7th/cmp-nvim-lsp"}
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

vim.g.lightline = {
  colorscheme = 'nord',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}
