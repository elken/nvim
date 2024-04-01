--[[
LSP is short for "Language Server Protocol" and in essence, it defines a standard for tools to interact with a codebase.

Using a server-client arcitecture, a "server" can be written in any language but MUST implement the protocol. Then any client, which would be a plugin in your editor, can interact with that server to gain more context about the rest of the project.

Similar to how treesitter works with providing an AST of the single buffer, LSP works in the opposite direction and provdies a kind-of tree of the entire project; which symbol maps to where, where it comes from, where it's used etc.

We leverage a fantastic package here called Mason to pull in the various servers we need as well as linters, formatters, etc and use the servers we pull from Mason to seed the list of servers we autoconfigure.

Want to add a new language? Add the server name to `ensure_installed`, install it in Mason manually (or restart) then restart so the new language will be configured at startup and ... that's it.
--]]
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    local function make_opts(desc, ...)
      return vim.tbl_deep_extend("force", { buffer = ev.buf, desc = desc }, ... or {})
    end

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings based on server support
    -- When an LSP server is sent initialize, it returns the list of capabilities it supports.
    -- We use that here to prevent binding things that will just cause errors.
    if client and client.server_capabilities.declarationProvider then
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, make_opts("Go To Declaration"))
    end

    if client and client.server_capabilities.definitionProvider then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, make_opts("Go To Definition"))
    end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, make_opts("Show documentation for symbol"))

    if client and client.server_capabilities.implementationProvider then
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, make_opts("Go To Implementations"))
    end

    if client and client.server_capabilities.renameProvider then
      vim.keymap.set("n", "gR", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, make_opts("Rename Symbol", { expr = true }))
    end

    if client and client.server_capabilities.codeActionProvider then
      vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, make_opts("Code actions"))
    end
    if client and client.server_capabilities.referencesProvider then
      vim.keymap.set("n", "gr", vim.lsp.buf.references, make_opts("Find References"))
    end
  end,
})

return {
  "neovim/nvim-lspconfig",
  config = function()
    require("neoconf").setup({})
    require("neodev").setup({
      library = {
        plugins = {
          "neotest",
        },
        types = true,
      },
    })
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Configure lua language server for neovim development
    local mason = require("mason")
    mason.setup({})

    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = {
        "bashls",
        "clojure_lsp",
        "docker_compose_language_service",
        "dockerls",
        "dotls",
        "elixirls",
        "emmet_ls",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "sqlls",
        "tailwindcss",
        "taplo",
        "terraformls",
        "tsserver",
        "typst_lsp",
        "vimls",
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

    local config = {
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
  end,
  dependencies = {
    "folke/which-key.nvim",
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          border = "rounded",
        },
      },
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
    {
      "smjonas/inc-rename.nvim",
      opts = {},
    },
  },
}