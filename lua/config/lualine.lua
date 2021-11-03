local M = {}

local function lsp_in_use()
  return table.maxn(vim.lsp.get_active_clients()) > 0
end
local function hide_in_width()
  return vim.fn.winwidth(0) > 80
end
local function buffer_not_empty()
  return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
end
local function lsp_servers()
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local servers = vim.lsp.get_active_clients()
  local result = {}
  for _, v in ipairs(servers) do
    if not vim.tbl_contains(result, v.name) and vim.tbl_contains(v.config.filetypes, buf_ft) then
      table.insert(result, v.name)
    end
  end
  return (table.concat(result, ","))
end

function M.setup()
  require("lualine").setup({
    options = {
      theme = "nord",
      section_separators = { left = "", right = "" },
      component_separators = { left = "╲", right = "╱" },
    },
    sections = {
      lualine_b = { { "branch", cond = hide_in_width } },
      lualine_c = {
        { "filetype", icon_only = true, separator = { right = "" }, padding = { left = 1 } },
        {
          lsp_servers,
          color = { gui = "bold" },
          cond = function()
            return lsp_in_use() and hide_in_width()
          end,
        },
        {
          "filename",
          file_status = true,
          symbols = { modified = " ", readonly = " " },
          path = 0,
          separator = { right = "" },
          cond = function()
            return buffer_not_empty() and not hide_in_width()
          end,
        },
        {
          "filename",
          file_status = true,
          symbols = { modified = " ", readonly = " " },
          path = 1,
          separator = { right = "" },
          cond = function()
            return buffer_not_empty() and hide_in_width()
          end,
        },
        {
          "%=",
          separator = { left = "", right = "" },
        },
        "lsp-progress",
      },
      lualine_x = {
        { "diff", symbols = { added = " ", modified = " ", removed = " " } },
        { "diagnostics", sources = { "nvim_lsp" } },
        { require("github-notifications").statusline_notification_count },
      },
      lualine_y = {
        { "encoding", cond = hide_in_width },
        {
          "fileformat",
          cond = function()
            local options = {
              unix = { "unix", "mac", "bsd", "wsl" },
              mac = { "mac" },
              dos = { "win32" },
            }
            for _, os in ipairs(options[vim.bo.fileformat]) do
              if vim.fn.has(os) then
                return false
              end
            end
            return true
          end,
        },
      },
    },
    inactive_sections = {
      lualine_a = { "winnr" },
      lualine_b = {},
      lualine_c = {
        {
          "filename",
          file_status = true,
          path = 0,
          separator = { right = "" },
          cond = function()
            return buffer_not_empty() and not hide_in_width()
          end,
        },
        {
          "filename",
          file_status = true,
          path = 1,
          separator = { right = "" },
          cond = function()
            return buffer_not_empty() and hide_in_width()
          end,
        },
      },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = {
      "quickfix",
      "toggleterm",
      "fugitive",
    },
  })
end

return M
