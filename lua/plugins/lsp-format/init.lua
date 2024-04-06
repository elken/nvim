--[[
Module based on https://github.com/lukas-reineke/lsp-format.nvim

Creates a system that lets me control automatic formatting based on LSP by creating a global table to track whether or not a specific buffer ID has been added. Over time, this may grow to handling default file paths to "always" ignore but my usage for now is fine.

Thanks to autocommands, we can also call "redrawstatus" to update the modeline segment that denotes whether autoformatting is enabled or not.
--]]

local M = {}
M.disabled_buffers = {}

local function set_buffer(value, buf)
  buf = buf or vim.api.nvim_get_current_buf()
  M.disabled_buffers[tostring(buf)] = value
end

M.is_enabled = function(buf)
  buf = buf or vim.api.nvim_get_current_buf()

  return M.disabled_buffers[tostring(buf)] == nil
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
  command = "LspFormat",
})

vim.api.nvim_create_user_command("LspFormatToggle", function()
  set_buffer(M.is_enabled() and true or nil)

  vim.api.nvim_exec_autocmds("User", {
    pattern = "LspFormatToggle",
    modeline = false,
    data = {
      bufnr = vim.api.nvim_get_current_buf(),
      disabled = M.is_enabled() and true or nil,
    },
  })
end, {})

vim.api.nvim_create_user_command("LspFormat", function()
  if M.is_enabled() then
    vim.lsp.buf.format({ async = false })
  end
end, {})

vim.api.nvim_create_autocmd("User", {
  pattern = "LspFormatToggle",
  callback = vim.schedule_wrap(function()
    vim.cmd("redrawstatus")
  end),
})

return M
