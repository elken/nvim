local M = {}
local whichkey = require("which-key")
local function TelescopeCodeActions()
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

function M.setup()
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
        globals = { "vim", "awesome", "client", "root" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          ["/usr/share/nvim/runtime/lua"] = true,
          ["/usr/share/awesome/lib"] = true,
        },
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
end

return M
