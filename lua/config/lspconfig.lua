local M = {}
require("neoconf").setup({})
require("neodev").setup({
  library = {
    plugins = {
      "neotest",
    },
    types = true,
  },
})

-- Borrowed from https://github.com/kabouzeid/nvim-lspinstall/wiki
-- keymaps
local on_attach = function(_client, bufnr)
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
  local function make_opts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = desc }
  end

  vim.keymap.set("n", "K", vim.lsp.buf.hover, make_opts("Show documentation for symbol"))
  vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<cr>", make_opts("Code Actions"))
  vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", make_opts("Go To Definition"))
  vim.keymap.set("n", "gD", "<cmd>Lspsaga goto_type_definition<cr>", make_opts("Go To Type Definition"))
  vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<cr>", make_opts("Find References"))
  vim.keymap.set("n", "gR", "<cmd>Lspsaga rename<cr>", make_opts("Rename Symbol"))
  vim.keymap.set("n", "]d", vim.lsp.diagnostic.goto_next(), make_opts("Go To Next Error"))
  vim.keymap.set("n", "[d", vim.lsp.diagnostic.goto_prev(), make_opts("Go To Previous Error"))
end

function M.setup()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Configure lua language server for neovim development
  local mason = require("mason")
  mason.setup({})

  require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = {
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
    },
  })

  local on_log_message = function(err, result, ctx, config)
    vim.lsp.handlers["window/logMessage"](err, result, ctx, config)

    -- Only do it for info/log type logs
    if result.type > 2 then
      local opts = { client_id = ctx.client_id }
      local token = tostring({}):sub(10) -- random string hack

      vim.lsp.handlers["$/progress"](nil, {
        token = token,
        value = { kind = "begin", title = result.message },
      }, opts)

      vim.lsp.handlers["$/progress"](nil, {
        token = token,
        value = { kind = "end" },
      }, opts)
    end
  end

  local lspconfig = require("lspconfig")

  local config = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  require("mason-lspconfig").setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup(config)
    end,
    ["clojure_lsp"] = function()
      config.handlers = {
        ["window/logMessage"] = on_log_message,
      }
      require("lspconfig")["clojure_lsp"].setup(config)
    end,
    ["lua_ls"] = function()
      config.settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      }
      require("lspconfig")["lua_ls"].setup(config)
    end,
  })
end

return M
