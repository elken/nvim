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
  callback = function()
    if M.is_enabled() then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

vim.api.nvim_create_user_command("LspFormatDisable", function()
  set_buffer(true)
end, {})

vim.api.nvim_create_user_command("LspFormatEnable", function()
  set_buffer(nil)
end, {})

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

return M
