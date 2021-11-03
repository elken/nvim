local M = {}

function M.setup()
  require("lspkind").init()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  cmp.setup({
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "luasnip" },
      { name = "orgmode" },
    }, {
      { name = "buffer" },
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-g>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {
        "i",
        "c",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "c",
      }),
    },
    formatting = {
      format = require("lspkind").cmp_format({
        with_text = true,
        maxwidth = 50,
        menu = {
          path = "[Path]",
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Latex]",
        },
      }),
    },
    documentation = {
      border = "single",
    },
  })

  cmp.setup.cmdline("/", {
    sources = cmp.config.sources({
      { name = "nvim_lsp_document_symbol" },
    }, {
      { name = "buffer" },
    }),
  })

  cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

return M
