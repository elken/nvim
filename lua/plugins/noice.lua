--[[
Wraps around various interfaces to provide some niceties, eg when you do `:!` you get a different prompt to indicate you're about to run a shell command.

We load this as late we can since we don't need it until we "need" it, otherwise the setup is mostly default with inc_rename turned on since we take great use of it.
--]]

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      signature = { enabled = false },
      hover = { enabled = false },
      message = { enabled = false },
      -- override markdown rendering so that **cmp** and other plugins  **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, --  a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = {
        background_colour = "#000000",
        render = "compact",
        timeout = 3000,
      },
    },
  },
}
