--[[
Config for my bespoke statusline borrowed from https://github.com/olimorris/dotfiles/blob/main/.config/nvim/lua/plugins/heirline/init.lua.

In this we define a statusline that incorporates a number of segments:
- The current mode (always visible)
- The current git branch along with the various status change statistics
- A listing of all the diagnostics (hidden when not applicable)
- A listing of all the LSP servers and a green or red cog to indicate if the current buffer has formatting enabled on save
- A display of the current macro being recorded (hidden when not applicable)
- The number of current lazy.nvim package updates

In a nicely centred statusline, notably missing the buffer name which is taken care of by incline.nvim
--]]
local conditions = require("heirline.conditions")
local palette = require("nightfox.palette").load("nordfox")
local statusline_bg = palette.bg1
local bg = palette.bg0

local LeftRounded = " "
local RightRounded = " "

local mode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
    self.mode_color = self.mode_colors[self.mode:sub(1, 1)]
  end,
  static = {
    mode_names = {
      n = "NORMAL",
      no = "NORMAL",
      nov = "NORMAL",
      noV = "NORMAL",
      ["no\22"] = "NORMAL",
      niI = "NORMAL",
      niR = "NORMAL",
      niV = "NORMAL",
      nt = "NORMAL",
      v = "VISUAL",
      vs = "VISUAL",
      V = "VISUAL",
      Vs = "VISUAL",
      ["\22"] = "VISUAL",
      ["\22s"] = "VISUAL",
      s = "SELECT",
      S = "SELECT",
      ["\19"] = "SELECT",
      i = "INSERT",
      ic = "INSERT",
      ix = "INSERT",
      R = "REPLACE",
      Rc = "REPLACE",
      Rx = "REPLACE",
      Rv = "REPLACE",
      Rvc = "REPLACE",
      Rvx = "REPLACE",
      c = "COMMAND",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "TERM",
    },
    mode_colors = {
      n = palette.blue.base,
      i = palette.green.base,
      v = palette.magenta.base,
      V = palette.magenta.base,
      ["\22"] = palette.magenta.base,
      c = palette.magenta.base,
      s = palette.yellow.base,
      S = palette.yellow.base,
      ["\19"] = palette.yellow.base,
      r = palette.orange.bright,
      R = palette.orange.bright,
      ["!"] = palette.red.dim,
      t = palette.red.dim,
    },
  },
  {
    provider = LeftRounded,
    hl = function(self)
      return { fg = self.mode_color, bg = bg }
    end,
  },
  {
    provider = function(self)
      return " %2(" .. self.mode_names[self.mode] .. "%) "
    end,
    hl = function(self)
      return { fg = bg, bg = self.mode_color }
    end,
  },
  {
    provider = RightRounded,
    hl = function(self)
      return { fg = self.mode_color, bg = bg }
    end,
  },
}

local git_branch = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
  end,
  {
    condition = function(self)
      return not conditions.buffer_matches({
        filetype = self.filetypes,
      })
    end,
    {
      provider = LeftRounded,
      hl = { fg = statusline_bg, bg = bg },
    },
    {
      provider = function(_)
        return " "
      end,
      hl = { fg = palette.green.bright },
    },
    {
      provider = function(self)
        return string.sub(self.status_dict.head, 1, 30)
      end,
      hl = { fg = palette.fg1, bold = true },
    },
    {
      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and string.format("   %s", count)
      end,
      hl = { fg = palette.green.bright },
    },
    {
      provider = function(self)
        local count = self.status_dict.removed or 0
        return count > 0 and string.format("   %s", count)
      end,
      hl = { fg = palette.red.bright },
    },
    {
      provider = function(self)
        local count = self.status_dict.changed or 0
        return count > 0 and string.format("   %s", count)
      end,
      hl = { fg = palette.yellow.bright },
    },
    {
      provider = RightRounded,
      hl = { fg = statusline_bg, bg = bg },
    },
  },
}

local diagnostics = {
  condition = conditions.has_diagnostics,
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  -- Errors
  {
    condition = function(self)
      return self.errors > 0
    end,
    hl = { fg = bg, bg = palette.red.bright },
    {
      {
        provider = LeftRounded,
        hl = { bg = bg, fg = palette.red.bright },
      },
      {
        provider = function(self)
          return vim.fn.sign_getdefined("DiagnosticSignError")[1].text .. self.errors
        end,
      },
      {
        provider = RightRounded,
        hl = { bg = bg, fg = palette.red.bright },
      },
    },
  },
  -- Warnings
  {
    condition = function(self)
      return self.warnings > 0
    end,
    hl = { fg = bg, bg = palette.yellow.bright },
    {
      {
        provider = LeftRounded,
        hl = { bg = bg, fg = palette.yellow.bright },
      },
      {
        provider = function(self)
          return vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text .. self.warnings
        end,
      },
      {
        provider = RightRounded,
        hl = { bg = bg, fg = palette.yellow.bright },
      },
    },
  },
  -- Info
  {
    condition = function(self)
      return self.info > 0
    end,
    hl = { bg = palette.green.bright, fg = bg },
    {
      {
        provider = LeftRounded,
        hl = { bg = bg, fg = palette.green.bright },
      },
      {
        provider = function(self)
          return " " .. vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text .. self.info
        end,
      },
      {
        provider = RightRounded,
        hl = { bg = bg, fg = palette.green.bright },
      },
    },
  },
}

local lsp_servers = {
  condition = conditions.lsp_attached,
  init = function(self)
    self.servers = {}
    for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      local len = #self.servers
      if len == 0 or self.servers[len] ~= server.name then
        self.servers[len + 1] = server.name
      end
    end
  end,
  {
    {
      provider = LeftRounded,
      hl = { bg = bg, fg = statusline_bg },
    },
    {
      provider = "  ",
      update = { "User", pattern = "FormatToggle" },
      hl = function()
        local hl = { bg = statusline_bg }
        if vim.b[0].disable_autoformat or vim.g.disable_autoformat then
          hl.fg = palette.red.bright
        else
          hl.fg = palette.green.bright
        end
        return hl
      end,
    },
    {
      update = { "LspAttach", "LspDetach" },
      provider = function(self)
        return table.concat(self.servers, ", ")
      end,
      hl = { fg = palette.fg, bg = statusline_bg, bold = true },
    },
    {
      provider = RightRounded,
      hl = { bg = bg, fg = statusline_bg },
    },
  },
}

local macro = {
  condition = function()
    return vim.fn.reg_recording() ~= ""
  end,
  update = {
    "RecordingEnter",
    "RecordingLeave",
  },
  {
    provider = LeftRounded,
    hl = { fg = palette.blue.base, bg = bg },
  },
  {
    provider = function()
      return "@" .. vim.fn.reg_recording()
    end,
    hl = { bg = palette.blue.base, fg = bg },
  },
  {
    provider = RightRounded,
    hl = { fg = palette.blue.base, bg = bg },
  },
}

local plugin_updates = {
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    }) and require("lazy.status").has_updates()
  end,
  update = {
    "User",
    pattern = "LazyCheck",
    callback = vim.schedule_wrap(function()
      vim.cmd("redrawstatus")
    end),
  },
  {
    {
      provider = LeftRounded,
      hl = { fg = statusline_bg, bg = bg },
    },
    {
      provider = function()
        return require("lazy.status").updates()
      end,
    },
    {
      provider = RightRounded,
      hl = { fg = statusline_bg, bg = bg },
    },
  },
  on_click = {
    callback = function()
      require("lazy").update()
    end,
    name = "sl_plugins_click",
  },
  hl = { fg = "gray" },
}

return {
  { provider = "%=" },
  mode,
  git_branch,
  diagnostics,
  lsp_servers,
  macro,
  plugin_updates,
  { provider = "%=" },
}
