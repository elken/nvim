--[[
Config for my bespoke statuscolumn borrowed from https://github.com/olimorris/dotfiles/blob/main/.config/nvim/lua/plugins/heirline/init.lua.

In this we define quite a large statuscolumn that incorporates a number of items:
- Breakpoints that can be toggled by clicking as well as the default keybind
- Arrows to open/close folds
- Markers for git hunks
- Diagnostic markers
- Markers for TODO: like things
- Markers for passing tests

The larger-than-normal width is to neatly incorporate all of the above without having too much overlap.
--]]

local v, fn, api = vim.v, vim.fn, vim.api

local conditions = require("heirline.conditions")

local align = { provider = "%=" }
local spacer = { provider = " ", hl = "HeirlineStatusColumn" }

return {
  {
    condition = function()
      return not conditions.buffer_matches({
        buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
        filetype = { "alpha", "codecompanion", "harpoon", "oil", "lspinfo", "toggleterm" },
      })
    end,
    static = {
      get_signs = function(self, bufnr, lnum)
        local signs = {}

        if vim.fn.has("nvim-0.10") then
          local extmarks = api.nvim_buf_get_extmarks(0, bufnr, { lnum - 1, 0 }, { lnum - 1, -1 }, { details = true, type = "sign" })

          for _, extmark in pairs(extmarks) do
            -- Exclude gitsigns
            if extmark[4].ns_id ~= self.git_ns then
              signs[#signs + 1] = {
                name = extmark[4].sign_hl_group or "",
                text = extmark[4].sign_text,
                sign_hl_group = extmark[4].sign_hl_group,
                priority = extmark[4].priority,
              }
            end
          end
        else
          signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
            group = "*",
            lnum = vim.v.lnum,
          })

          -- Filter out git signs
          signs = vim.tbl_filter(function(sign)
            return not vim.startswith(sign.group, "gitsigns")
          end, signs[1].signs)

          -- Update sign meta data
          for _, sign in ipairs(signs) do
            sign.text = vim.fn.sign_getdefined(sign.name)[1].text
            sign.sign_hl_group = sign.name
          end
        end

        table.sort(signs, function(a, b)
          return (a.priority or 0) > (b.priority or 0)
        end)

        return signs
      end,
      git_ns = api.nvim_create_namespace("gitsigns_extmark_signs_"),
      click_args = function(self, minwid, clicks, button, mods)
        local args = {
          minwid = minwid,
          clicks = clicks,
          button = button,
          mods = mods,
          mousepos = fn.getmousepos(),
        }
        local sign = fn.screenstring(args.mousepos.screenrow, args.mousepos.screencol)
        if sign == " " then
          sign = fn.screenstring(args.mousepos.screenrow, args.mousepos.screencol - 1)
        end
        args.sign = self.signs[sign]
        api.nvim_set_current_win(args.mousepos.winid)
        api.nvim_win_set_cursor(0, { args.mousepos.line, 0 })

        return args
      end,
      resolve = function(self, name)
        for pattern, callback in pairs(self.handlers.Signs) do
          if name:match(pattern) then
            return vim.defer_fn(callback, 100)
          end
        end
      end,
      handlers = {
        Signs = {
          ["Neotest.*"] = function(self, args)
            require("neotest").run.run()
          end,
          ["Debug.*"] = function(self, args)
            require("dap").continue()
          end,
          ["Diagnostic.*"] = function(self, args)
            vim.diagnostic.open_float()
          end,
        },
        Dap = function(self, args)
          require("dap").toggle_breakpoint()
        end,
        Fold = function(args)
          local line = args.mousepos.line
          if fn.foldlevel(line) <= fn.foldlevel(line - 1) then
            return
          end
          vim.cmd.execute("'" .. line .. "fold" .. (fn.foldclosed(line) == -1 and "close" or "open") .. "'")
        end,
        GitSigns = function(self, args)
          vim.defer_fn(function()
            require("gitsigns").blame_line({ full = true })
          end, 100)
        end,
      },
    },
    init = function(self)
      self.signs = {}
    end,
    -- Signs (except for GitSigns)
    {
      init = function(self)
        local signs = self.get_signs(self, -1, v.lnum)
        self.sign = signs[1]
      end,
      provider = function(self)
        return self.sign and self.sign.text or "  "
      end,
      hl = function(self)
        return self.sign and self.sign.sign_hl_group
      end,
      on_click = {
        name = "sc_sign_click",
        update = true,
        callback = function(self, ...)
          local line = self.click_args(self, ...).mousepos.line
          local sign = self.get_signs(self, -1, line)[1]
          if sign then
            self:resolve(sign.name)
          end
        end,
      },
    },
    align,
    -- Folds
    {
      init = function(self)
        self.can_fold = fn.foldlevel(v.lnum) > fn.foldlevel(v.lnum - 1)
      end,
      {
        condition = function(self)
          return v.virtnum == 0 and self.can_fold
        end,
        provider = " %C ",
      },
      {
        condition = function(self)
          return not self.can_fold
        end,
        spacer,
      },
      on_click = {
        name = "sc_fold_click",
        callback = function(self, ...)
          self.handlers.Fold(self.click_args(self, ...))
        end,
      },
    },
    -- Line Numbers
    {
      provider = "%= %4{v:virtnum ? '' : &nu ? (&rnu && v:relnum ? v:relnum : v:lnum) . ' ' : ''}",
      on_click = {
        name = "sc_linenumber_click",
        callback = function(self, ...)
          self.handlers.Dap(self.click_args(self, ...))
        end,
      },
    },
    -- Git Signs
    {
      {
        condition = function()
          return conditions.is_git_repo()
        end,
        init = function(self)
          local extmark = api.nvim_buf_get_extmarks(0, self.git_ns, { v.lnum - 1, 0 }, { v.lnum - 1, -1 }, { limit = 1, details = true })[1]

          self.sign = extmark and extmark[4]["sign_hl_group"]
        end,
        {
          provider = "│",
          hl = function(self)
            return self.sign or { fg = "bg" }
          end,
        },
      },
      {
        condition = function()
          return not conditions.is_git_repo()
        end,
        spacer,
      },
    },
  },
}
