--[[
DAP is short for Debugger Adapter Protocol; and behaves similar to how LSP works but for debugging.

The only proven setup is the ruby bits, and even then there's still some minor issues with regards to closing the session and clearing all the buffers cleanly.
--]]

return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup({})
      require("dap-ruby").setup()

      local dap = require("dap")
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }
      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8088 })
      end
      dap.adapters.flutter = {
        type = "executable",
        command = "flutter",
        args = { "debug_adapter" },
      }

      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F13>", dap.restart)

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    end,
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "jbyuki/one-small-step-for-vimkind",
      "suketa/nvim-dap-ruby",
    },
  },

  -- UI for above
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    after = "nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
  },

  -- EZ installer for DAP servers
  {
    "Pocco81/dap-buddy.nvim",
    config = function()
      local dap = require("dap-install")

      local debugger_list = require("dap-install.debuggers_list").debuggers

      for debugger, _ in pairs(debugger_list) do
        dap.config(debugger, {})
      end
    end,
    cmd = { "DIInstall", "DIUninstall", "DIList" },
  },
}
