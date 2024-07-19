--[[
My completion framework of choice, since I don't want to complex hassle that is coc; although I do mean to check it out from time-to-time...

This is also where snippets are setup, since they exist as a direct dependency.
--]]

return {
  "hrsh7th/nvim-cmp",
  config = function()
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
          mode = "symbol",
          maxwidth = 50,
        }),
      },
      window = {
        documentation = cmp.config.window.bordered(),
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

    -- Setup up vim-dadbod
    cmp.setup.filetype({ "sql" }, {
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
      },
    })
  end,
  dependencies = {
    "nvim-treesitter",
    "hrsh7th/cmp-nvim-lsp",
    "onsails/lspkind-nvim",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip").filetype_extend("ruby", { "rails" })
          end,
        },
      },
    },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
}
