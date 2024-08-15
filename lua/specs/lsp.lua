--[[
LSP is short for "Language Server Protocol" and in essence, it defines a standard for tools to interact with a codebase.

Using a server-client architecture, a "server" can be written in any language but MUST implement the protocol. Then any client, which would be a plugin in your editor, can interact with that server to gain more context about the rest of the project.

Similar to how tree-sitter works with providing an AST of the single buffer, LSP works in the opposite direction and provides a kind-of tree of the entire project; which symbol maps to where, where it comes from, where it's used etc.

We leverage a fantastic package here called Mason to pull in the various servers we need as well as linters, formatters, etc. and use the servers we pull from Mason to seed the list of servers we autoconfigure.

Want to add a new language? Add the server name to `ensure_installed`, install it in Mason manually (or restart) then restart so the new language will be configured at start-up and ... that's it.
--]]

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client and client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, ev.buf)
    end

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
    local lspconfig = require("lspconfig")
    require("neoconf").setup({})
    require("neodev").setup({
      override = function(_, library)
        library.enabled = true
        library.plugins = true
      end,
      pathStrict = true,
    })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    -- Include capabilities from cmp_nvim_lsp and lsp-file-operations
    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities(),
      require("lsp-file-operations").default_capabilities()
    )

    lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
      capabilities = capabilities,
    })

    -- Configure lua language server for neovim development
    local mason = require("mason")
    mason.setup({})

    -- Bootstrap needed tools
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- LSP
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
        "ruby_lsp",
        "sqlls",
        "tailwindcss",
        "taplo",
        "terraformls",
        "tsserver",
        "typst_lsp",
        "vimls",

        -- DAP
        -- Linters
        "clj-kondo",
        "markdownlint",
        "selene",
        "shellcheck",
        "vale",

        -- Formatters
        "erb-formatter",
        "mdformat",
        "prettierd",
        "rubocop",
        "rustywind",
        "shfmt",
        "sql-formatter",
        "stylua",
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

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["clojure_lsp"] = function()
        require("lspconfig")["clojure_lsp"].setup({
          capabilities = capabilities,
          handlers = {
            ["window/logMessage"] = on_log_message,
          },
        })
      end,
      -- Needed short-term until neovim supports `DiagnosticRegistrationOptions`
      ["ruby_lsp"] = function()
        require("lspconfig").ruby_lsp.setup({
          filetypes = { "ruby" },
        })
      end,
    })
  end,
  dependencies = {
    "SmiteshP/nvim-navic",
    {
      "folke/neodev.nvim",
      lazy = false,
      dependencies = {
        "folke/neoconf.nvim",
      },
    },
    "folke/which-key.nvim",
    "WhoIsSethDaniel/mason-tool-installer",
    {
      "stevearc/conform.nvim",
      init = function()
        -- Used when `gq` and others are called
        -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      end,
      config = function()
        require("conform").setup({
          formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescriptreact = { "prettierd" },
            eruby = { "erb_format" },
            markdown = { "prettierd" },
            zsh = { "shfmt" },
            sql = { "sql_formatter" },
          },
          format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
          end,
        })

        vim.api.nvim_create_user_command("FormatToggle", function(args)
          local disabled = false

          if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = not vim.b.disable_autoformat
            disabled = vim.b.disable_autoformat
          else
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            disabled = vim.g.disable_autoformat
          end

          vim.api.nvim_exec_autocmds("User", {
            pattern = "FormatToggle",
            modeline = false,
            data = {
              bufnr = vim.api.nvim_get_current_buf(),
              disabled = disabled,
            },
          })
        end, {
          desc = "Toggle autoformat on save",
          bang = true,
        })

        vim.api.nvim_create_autocmd("User", {
          pattern = "FormatToggle",
          callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
          end),
        })
      end,
    },
    {
      "mfussenegger/nvim-lint",
      config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
          javascript = { "eslint_d" },
          typescript = { "eslint_d" },
          javascriptreact = { "eslint_d" },
          typescriptreact = { "eslint_d" },
          clojure = { "clj-kondo" },
          markdown = { "markdownlint" },
          lua = { "selene" },
          zsh = { "shellcheck" },
          bash = { "shellcheck" },
        }

        local augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
          group = augroup,
          callback = function()
            local client = vim.lsp.get_clients({ bufnr = 0 })[1] or {}
            lint.try_lint(nil, { cwd = client.root_dir or vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":h") })
          end,
        })
      end,
    },
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          border = "rounded",
        },
      },
      "williamboman/mason-lspconfig.nvim",
      {
        "smjonas/inc-rename.nvim",
        opts = {},
      },
    },
  },
}
