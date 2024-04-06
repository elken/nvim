--[[
DAP is short for Debugger Adapter Protocol; and behaves similar to how LSP works but for debugging.

I really don't use this much at all, so this is again considered dead code for now
--]]
return {
  -- {
  --   "mfussenegger/nvim-dap",
  --   config = function()
  --     require("nvim-dap-virtual-text").setup({})
  --     local dap = require("dap")
  --     dap.configurations.lua = {
  --       {
  --         type = "nlua",
  --         request = "attach",
  --         name = "Attach to running Neovim instance",
  --       },
  --     }
  --     dap.adapters.nlua = function(callback, config)
  --       callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8088 })
  --     end
  --     dap.adapters.flutter = {
  --       type = "executable",
  --       command = "flutter",
  --       args = { "debug_adapter" },
  --     }
  --     vim.cmd([[
  --           nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
  --           nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
  --           nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
  --           nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
  --           nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
  --           nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
  --           nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
  --           ]])
  --   end,
  --   dependencies = {
  --     "theHamsta/nvim-dap-virtual-text",
  --     "jbyuki/one-small-step-for-vimkind",
  --   },
  -- },

  -- -- UI for above
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   config = function()
  --     local dap, dapui = require("dap"), require("dapui")
  --     dapui.setup()
  --     dap.listeners.after.event_initialized["dapui_config"] = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.event_terminated["dapui_config"] = function()
  --       dapui.close()
  --     end
  --     dap.listeners.before.event_exited["dapui_config"] = function()
  --       dapui.close()
  --     end
  --   end,
  --   after = "nvim-dap",
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --   },
  -- },

  -- -- EZ installer for DAP servers
  -- {
  --   "Pocco81/dap-buddy.nvim",
  --   config = function()
  --     local dap = require("dap-install")

  --     local debugger_list = require("dap-install.debuggers_list").debuggers

  --     for debugger, _ in pairs(debugger_list) do
  --       dap.config(debugger, {})
  --     end
  --   end,
  --   cmd = { "DIInstall", "DIUninstall", "DIList" },
  -- },
}
