local M = {}
local whichkey = require("which-key")

-- Borrowed from lunarvim
function M.LspCodeActions()
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
  require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_cursor(opts))
end

function M.LspDefinitions()
  local opts = {
    winblend = 15,
    layout_config = {
      prompt_position = "top",
      width = 130,
      height = 22,
    },
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    shorten_path = false,
  }
  require("telescope.builtin").lsp_definitions(require("telescope.themes").get_dropdown(opts))
end

function M.LspTypeDefinitions()
  local opts = {
    winblend = 15,
    layout_config = {
      prompt_position = "top",
      width = 130,
      height = 22,
    },
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    shorten_path = false,
  }
  require("telescope.builtin").lsp_type_definitions(require("telescope.themes").get_dropdown(opts))
end

function M.LspImplementations()
  local opts = {
    winblend = 15,
    layout_config = {
      prompt_position = "top",
      width = 130,
      height = 22,
    },
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    shorten_path = false,
  }
  require("telescope.builtin").lsp_implementations(require("telescope.themes").get_dropdown(opts))
end

function M.LspReferences()
  local opts = {
    winblend = 15,
    layout_config = {
      prompt_position = "top",
      width = 130,
      height = 22,
    },
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    shorten_path = false,
  }
  require("telescope.builtin").lsp_references(require("telescope.themes").get_dropdown(opts))
end

-- Borrowed from https://www.reddit.com/r/neovim/comments/ql4iuj/rename_hover_including_window_title_and/
-- TODO Improve to show live updates (maybe)
function M.LspRename()
  local rename = "textDocument/rename"
  local currName = vim.fn.expand("<cword>")
  local tshl = require("nvim-treesitter-playground.hl-info").get_treesitter_hl()
  if tshl and #tshl > 0 then
    local ind = tshl[#tshl]:match("^.*()%*%*.*%*%*")
    tshl = tshl[#tshl]:sub(ind + 2, -3)
  end

  local win = require("plenary.popup").create(currName, {
    title = "New Name",
    style = "minimal",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    relative = "cursor",
    borderhighlight = "FloatBorder",
    titlehighlight = "Title",
    highlight = tshl,
    focusable = true,
    width = 25,
    height = 1,
    line = "cursor+2",
    col = "cursor-1",
  })

  local map_opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(0, "i", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
  vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "<cmd>stopinsert | lua _rename('" .. currName .. "')<CR>", map_opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<cmd>stopinsert | lua _rename('" .. currName .. "')<CR>", map_opts)

  local function handler(err, result, ctx, config)
    if err then
      vim.notify(("Error running lsp query '%s': %s"):format(rename, err), vim.log.levels.ERROR)
    end
    local new
    if result and result.changes then
      local msg = ""
      for f, c in pairs(result.changes) do
        new = c[1].newText
        msg = msg .. ("%d changes -> %s"):format(#c, f:gsub("file://", ""):gsub(vim.fn.getcwd(), ".")) .. "\n"
        msg = msg:sub(1, #msg - 1)
        vim.notify(msg, vim.log.levels.INFO, { title = ("Rename: %s -> %s"):format(currName, new) })
      end
    end
    vim.lsp.handlers[rename](err, result, ctx, config)
  end

  function _G._rename(curr)
    local newName = vim.trim(vim.fn.getline("."))
    vim.api.nvim_win_close(win, true)
    if #newName > 0 and newName ~= curr then
      local params = vim.lsp.util.make_position_params()
      params.newName = newName
      vim.lsp.buf_request(0, rename, params, handler)
    end
  end
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
      d = { "<cmd>lua require('config.lspconfig').LspDefinitions()<CR>", "LSP Definitions" },
      D = { "<cmd>lua require('config.lspconfig').LspTypeDefinitions()<CR>", "LSP Type Definitions" },
      i = { "<cmd>lua require('config.lspconfig').LspImplementations()<CR>", "LSP Implementations" },
      r = { "<cmd>lua require('config.lspconfig').LspReferences()<CR>", "LSP References" },
      R = { "<cmd>lua require('config.lspconfig').LspRename()<CR>", "LSP Rename" },
      ["["] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Jump to previous error" },
      ["]"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Jump to next error" },
    },
    ["<leader>"] = {
      c = {
        name = "Code",
        a = { "<cmd>lua require('config.lspconfig').LspCodeActions()<CR>", "LSP Code Actions" },
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
