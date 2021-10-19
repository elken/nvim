-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/elken/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/elken/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/elken/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/elken/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/elken/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["DAPInstall.nvim"] = {
    commands = { "DIInstall", "DIUninstall", "DIList" },
    config = { "\27LJ\2\nï\1\0\0\v\0\6\0\0186\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0016\2\4\0\18\4\1\0B\2\2\4H\5\4Ä9\a\5\0\18\t\5\0004\n\0\0B\a\3\1F\5\3\3R\5˙K\0\1\0\vconfig\npairs\14debuggers\31dap-install.debuggers_list\16dap-install\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/opt/DAPInstall.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ale = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/bufdelete.nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\nï\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\3\20separator_style\nslant\27always_show_bufferline\1\16diagnostics\rnvim_lsp\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/cmp-emoji"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["detect-language.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/detect-language.nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/diffview.nvim"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/filetype.nvim"
  },
  firenvim = {
    config = { "\27LJ\2\n¶\4\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0Ü\4                au BufEnter github.com_*.txt set filetype=markdown\n                au BufEnter reddit.com_*.txt set filetype=markdown\n                let g:firenvim_config = { \"globalSettings\": { \"alt\": \"all\", }, \"localSettings\": { \".*\": { \"cmdline\": \"neovim\", \"content\": \"text\", \"priority\": 0, \"selector\": \"textarea\", \"takeover\": \"always\", }, } }\n                let fc = g:firenvim_config[\"localSettings\"]\n                let fc[\"https?://mail.google.com/\"] = { \"takeover\": \"never\", \"priority\": 1 }\n            \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  ["gitlinker.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14gitlinker\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/gitlinker.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nM\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\fkeymaps\1\0\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nè\4\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\21context_patterns\1\17\0\0\ntable\nclass\rfunction\vmethod\b^if\nwhile\bfor\twith\17func_literal\nblock\btry\vexcept\18argument_list\vobject\15dictionary\felement\20buftype_exclude\1\4\0\0\thelp\rterminal\vnofile\21filetype_exclude\1\0\3\24max_indent_increase\3\1\25show_current_context\2\19use_treesitter\2\1\22\0\0\rstartify\14dashboard\16dotooagenda\blog\rfugitive\14gitcommit\vpacker\fvimwiki\rmarkdown\tjson\btxt\nvista\thelp\ftodoist\rNvimTree\rpeekaboo\bgit\20TelescopePrompt\rundotree\24flutterToolsOutline\5\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lightspeed.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/lightspeed.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n†\1\0\0\b\0\6\1\31)\0\0\0)\1\1\0006\2\0\0009\2\1\0029\2\2\2'\4\3\0B\2\2\2)\3\1\0M\1\vÄ6\5\0\0009\5\1\0059\5\4\5\18\a\4\0B\5\2\2\15\0\5\0X\6\2Ä\a\5\5\0X\6\1Ä\22\0\0\0O\1ı)\1\1\0\1\1\0\0X\1\5Ä6\1\0\0009\1\1\0019\1\2\1D\1\1\0X\1\2Ä'\1\5\0L\1\2\0K\0\1\0\5\16win_gettype\6$\nwinnr\afn\bvim\2Á\3\1\0\a\0\26\0&3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\t\0005\4\4\0005\5\5\0=\5\6\0045\5\a\0=\5\b\4=\4\n\0035\4\f\0004\5\3\0>\0\1\0055\6\v\0>\6\2\5=\5\r\4=\4\14\0035\4\15\0004\5\3\0>\0\1\5=\5\16\0044\5\0\0=\5\17\0045\5\18\0=\5\r\0045\5\19\0=\5\20\0044\5\0\0=\5\21\0044\5\0\0=\5\22\4=\4\23\0035\4\24\0=\4\25\3B\1\2\1K\0\1\0\15extensions\1\4\0\0\rquickfix\15toggleterm\rfugitive\22inactive_sections\14lualine_z\14lualine_y\14lualine_x\1\2\0\0\rlocation\1\2\0\0\rfilename\14lualine_b\14lualine_a\1\0\0\rsections\14lualine_c\1\0\0\1\2\2\0\rfilename\tpath\3\1\16file_status\2\foptions\1\0\0\25component_separators\1\0\2\tleft\b‚ï≤\nright\b‚ï±\23section_separators\1\0\2\tleft\bÓÇ∏\nright\bÓÇ∫\1\0\1\ntheme\tnord\nsetup\flualine\frequire\0\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    config = { "\27LJ\2\n6\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\ffirefox\17mkdp_browser\6g\bvim\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  neogit = {
    config = { "\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/neogit"
  },
  ["nord.nvim"] = {
    config = { "\27LJ\2\n¶\1\0\0\3\0\a\0\0226\0\0\0009\0\1\0+\1\1\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\1\0009\0\4\0\14\0\0\0X\0\bÄ6\0\0\0009\0\5\0'\2\6\0B\0\2\0016\0\0\0009\0\1\0+\1\2\0=\1\4\0K\0\1\0\21colorscheme nord\bcmd\21colourscheme_set\17nord_borders\18nord_contrast\6g\bvim\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nord.nvim"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-bqf"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireö\1\0\1\3\2\4\0\21-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\vÄ-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4Ä-\1\1\0009\1\3\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\1¿\19expand_or_jump\23expand_or_jumpable\21select_next_item\fvisibleé\1\0\1\4\2\4\0\23-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\rÄ-\1\1\0009\1\2\1)\3ˇˇB\1\2\2\15\0\1\0X\2\5Ä-\1\1\0009\1\3\1)\3ˇˇB\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\1¿\tjump\rjumpable\21select_prev_item\fvisibleË\1\0\2\5\0\n\0\0176\2\1\0'\4\2\0B\2\2\0029\2\3\0029\2\4\0029\3\0\0018\2\3\2'\3\5\0009\4\0\1&\2\4\2=\2\0\0015\2\a\0009\3\b\0009\3\t\0038\2\3\2=\2\6\1L\1\2\0\tname\vsource\1\0\6\rnvim_lua\n[Lua]\fluasnip\14[LuaSnip]\18latex_symbols\f[Latex]\tpath\v[Path]\rnvim_lsp\n[LSP]\vbuffer\r[Buffer]\tmenu\6 \fdefault\fpresets\flspkind\frequire\tkindÿ\5\1\0\n\0/\0P6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0026\1\0\0'\3\4\0B\1\2\0029\2\5\0005\4\f\0004\5\a\0005\6\6\0>\6\1\0055\6\a\0>\6\2\0055\6\b\0>\6\3\0055\6\t\0>\6\4\0055\6\n\0>\6\5\0055\6\v\0>\6\6\5=\5\r\0045\5\15\0003\6\14\0=\6\16\5=\5\17\0045\5\20\0009\6\18\0009\6\19\6B\6\1\2=\6\21\0059\6\18\0009\6\22\6B\6\1\2=\6\23\0059\6\18\0009\6\24\6)\b¸ˇB\6\2\2=\6\25\0059\6\18\0009\6\24\6)\b\4\0B\6\2\2=\6\26\0059\6\18\0009\6\27\6B\6\1\2=\6\28\0059\6\18\0009\6\29\6B\6\1\2=\6\30\0059\6\18\0009\6\31\0065\b\"\0009\t \0009\t!\t=\t#\bB\6\2\2=\6$\0053\6%\0=\6&\0053\6'\0=\6(\5=\5\18\0045\5*\0003\6)\0=\6+\5=\5,\0045\5-\0=\5.\4B\2\2\0012\0\0ÄK\0\1\0\18documentation\1\0\1\vborder\vsingle\15formatting\vformat\1\0\0\0\f<S-Tab>\0\n<Tab>\0\t<CR>\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\n<C-g>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-d>\16scroll_docs\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\forgmode\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lua\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\nsetup\fluasnip\bcmp\tinit\flspkind\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-ui" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/opt/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n®\3\0\0\6\0\17\0\0255\0\0\0005\1\1\0=\1\2\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\0015\2\b\0=\2\t\1=\1\n\0004\1\0\0=\1\v\0006\1\f\0'\3\r\0B\1\2\0029\1\14\0016\3\f\0'\5\15\0B\3\2\0029\3\16\3\18\5\0\0B\3\2\0A\1\0\1K\0\1\0\17get_dropdown\21telescope.themes\21lsp_code_actions\22telescope.builtin\frequire\vborder\16borderchars\fpreview\1\t\0\0\b‚îÄ\b‚îÇ\b‚îÄ\b‚îÇ\b‚ï≠\b‚ïÆ\b‚ïØ\b‚ï∞\fresults\1\t\0\0\b‚îÄ\b‚îÇ\b‚îÄ\b‚îÇ\b‚îú\b‚î§\b‚ïØ\b‚ï∞\vprompt\1\0\0\1\t\0\0\b‚îÄ\b‚îÇ\6 \b‚îÇ\b‚ï≠\b‚ïÆ\b‚îÇ\b‚îÇ\18layout_config\1\0\3\vheight\3\f\nwidth\3P\20prompt_position\btop\1\0\3\17shorten_path\1\14previewer\1\rwinblend\3\15A\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1¿\24nvim_buf_set_option\bapi\bvimø\17\1\2\v\1A\0t6\2\0\0'\4\1\0B\2\2\0029\2\2\0025\4\3\0005\5\4\0=\5\5\4\18\5\1\0B\2\3\0013\2\6\0006\3\a\0009\3\b\0039\3\t\0036\4\a\0009\4\b\0049\4\v\0046\6\a\0009\6\b\0069\6\t\0069\6\f\0065\a\r\0B\4\3\2=\4\n\0036\3\a\0009\3\b\0039\3\t\0036\4\a\0009\4\b\0049\4\v\0046\6\a\0009\6\b\0069\6\t\0069\6\f\0065\a\15\0B\4\3\2=\4\14\3\18\3\2\0'\5\16\0'\6\17\0B\3\3\0015\3\18\0=\1\19\3-\4\0\0009\4\20\0045\6\22\0005\a\21\0=\a\23\0065\a\25\0005\b\24\0=\b\26\a5\b\27\0=\b\28\a5\b\29\0=\b\30\a5\b\31\0=\b \a=\a!\0065\a/\0005\b\"\0005\t#\0=\t$\b5\t%\0=\t&\b5\t'\0005\n(\0=\n$\t5\n)\0=\n \t5\n*\0=\n+\t=\t,\b5\t-\0=\t.\b=\b&\a5\b0\0=\b1\a5\b2\0=\b3\a=\a4\6\18\a\3\0B\4\3\0019\0045\0009\0046\4\15\0\4\0X\5\bÄ-\4\0\0009\4\20\0045\0068\0005\a7\0=\a9\6\18\a\3\0B\4\3\1X\4\vÄ9\0045\0009\4:\4\15\0\4\0X\5\aÄ-\4\0\0009\4\20\0045\6<\0005\a;\0=\a9\6\18\a\3\0B\4\3\0019\0045\0009\4=\4\15\0\4\0X\5\6Ä6\4\a\0009\4>\0049\4?\4'\6@\0+\a\1\0B\4\3\0012\0\0ÄK\0\1\0\0¿¡\2                    augroup lsp_document_highlight\n                    autocmd! * <buffer>\n                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n                    augroup END\n                        \14nvim_exec\bapi\23document_highlight\1\0\0\1\3\0\0000<cmd>lua vim.lsp.buf.range_formatting()<CR>\25Format buffer/region\30document_range_formatting\15<leader>cf\1\0\0\1\3\0\0*<cmd>lua vim.lsp.buf.formatting()<CR>\18Format buffer\24document_formatting\26resolved_capabilities\r<leader>\6]\1\3\0\0000<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\23Jump to next error\6[\1\3\0\0000<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\27Jump to previous error\1\0\0\6x\1\3\0\0O<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = 'single'})<CR>\30Show diagnostics for line\6w\6l\1\3\0\0K<cmd> lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>\27List workspace folders\1\3\0\0007<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>\28Remove workspace folder\1\3\0\0004<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>\25Add workspace folder\1\0\1\tname\15Workspaces\6c\1\3\0\0\18<cmd>Make<CR>\fCompile\6a\1\3\0\0(<cmd>lua TelescopeCodeActions()<CR>\21LSP Code Actions\1\0\1\tname\tCode\6g\6r\1\3\0\0*<cmd>lua vim.lsp.buf.references()<CR>\19LSP references\6i\1\3\0\0.<cmd>lua vim.lsp.buf.implementation()<CR>\23LSP implementation\6D\1\3\0\0+<cmd>lua vim.lsp.buf.declaration()<CR>\20LSP declaration\6d\1\0\0\1\3\0\0*<cmd>lua vim.lsp.buf.definition()<CR>\19LSP definition\6K\1\0\0\1\3\0\0%<cmd>lua vim.lsp.buf.hover()<CR>\"Show documentation for symbol\rregister\vbuffer\1\0\2\vsilent\2\fnoremap\2\27v:lua.vim.lsp.omnifunc\romnifunc\1\0\1\vborder\vsingle\31textDocument/signatureHelp\1\0\1\vborder\vsingle\nhover\twith\23textDocument/hover\rhandlers\blsp\bvim\0\17handler_opts\1\0\1\vborder\vsingle\1\0\1\tbind\2\14on_attach\18lsp_signature\frequire¥\1\0\1\6\3\n\0\0195\1\0\0-\2\0\0=\2\1\1-\2\1\0=\2\2\0019\2\3\0\a\2\4\0X\2\2Ä-\2\2\0=\2\5\1\18\4\0\0009\2\6\0\18\5\1\0B\2\3\0016\2\a\0009\2\b\2'\4\t\0B\2\2\1K\0\1\0\2Ä\1¿\4¿\29do User LspAttachBuffers\bcmd\bvim\nsetup\rsettings\16sumneko_lua\tname\14on_attach\17capabilities\1\0\0€\4\1\0\v\0'\0?6\0\0\0'\2\1\0B\0\2\0023\1\2\0007\1\3\0003\1\4\0006\2\5\0009\2\6\0029\2\a\0029\2\b\2B\2\1\0026\3\0\0'\5\t\0B\3\2\0029\3\n\3\18\5\2\0B\3\2\2\18\2\3\0006\3\5\0009\3\v\0036\5\f\0009\5\r\5'\6\14\0B\3\3\0026\4\15\0009\4\16\4\18\6\3\0'\a\17\0B\4\3\0016\4\15\0009\4\16\4\18\6\3\0'\a\18\0B\4\3\0015\4\20\0005\5\19\0=\5\21\0045\5\23\0005\6\22\0=\3\r\6=\6\24\0055\6\26\0005\a\25\0=\a\27\6=\6\28\0055\6 \0006\a\5\0009\a\29\a9\a\30\a'\t\31\0+\n\2\0B\a\3\2=\a!\6=\6\"\5=\5#\0046\5\0\0'\a$\0B\5\2\0029\6%\0053\b&\0B\6\2\0012\0\0ÄK\0\1\0\0\20on_server_ready\23nvim-lsp-installer\bLua\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\16diagnostics\fglobals\1\0\0\1\2\0\0\bvim\fruntime\1\0\0\1\0\1\fversion\vLuaJIT\14filetypes\1\0\0\1\2\0\0\blua\19lua/?/init.lua\14lua/?.lua\vinsert\ntable\6;\tpath\fpackage\nsplit\24update_capabilities\17cmp_nvim_lsp\29make_client_capabilities\rprotocol\blsp\bvim\0\25TelescopeCodeActions\0\14which-key\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-neoclip.lua"] = {
    config = { "\27LJ\2\nW\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\30enable_persistant_history\2\nsetup\fneoclip\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-neoclip.lua"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\n2\0\0\4\0\3\0\0066\0\0\0006\1\2\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\frequire\vnotify\bvim\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-notify"
  },
  ["nvim-toggleterm.lua"] = {
    config = { "\27LJ\2\n®\4\0\0\6\0\26\0/6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\3=\3\6\0025\3\a\0005\4\b\0=\4\t\3=\3\n\2B\0\2\0016\0\4\0009\0\v\0009\0\f\0'\2\r\0'\3\14\0'\4\15\0005\5\16\0B\0\5\0016\0\4\0009\0\v\0009\0\f\0'\2\r\0'\3\17\0'\4\18\0005\5\19\0B\0\5\0016\0\4\0009\0\v\0009\0\f\0'\2\r\0'\3\20\0'\4\21\0005\5\22\0B\0\5\0016\0\4\0009\0\v\0009\0\f\0'\2\r\0'\3\23\0'\4\24\0005\5\25\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>l\n<C-l>\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>k\n<C-k>\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>j\n<C-j>\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>h\n<C-h>\6t\20nvim_set_keymap\bapi\15float_opts\15highlights\1\0\2\vborder\vNormal\15background\vNormal\1\0\2\vborder\vdouble\rwinblend\3\0\nshell\6o\bvim\1\0\2\14direction\15horizontal\20shade_terminals\1\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÁ\17\0\0\a\0F\0V6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\15\0\0\0X\1\5Ä6\0\4\0'\2\5\0B\0\2\0025\1\a\0=\1\6\0006\0\4\0'\2\b\0B\0\2\0029\0\t\0B\0\1\0025\1\14\0005\2\v\0005\3\f\0=\3\r\2=\2\15\1=\1\n\0005\1\19\0005\2\17\0005\3\18\0=\3\r\2=\2\15\1=\1\16\0006\1\4\0'\3\20\0B\1\2\0029\1\21\0015\3\22\0005\4\23\0=\4\24\0035\4\25\0005\5\26\0=\5\27\4=\4\28\0035\4\29\0=\4\30\0035\4\31\0005\5 \0=\5\27\4=\4!\0035\4\"\0=\4#\0035\4&\0005\5$\0005\6%\0=\6\27\5=\5'\0045\5(\0005\6)\0=\6*\0055\6+\0=\6,\0055\6-\0=\6.\0055\6/\0=\0060\5=\0051\4=\0042\0035\0043\0005\0054\0=\0055\4=\0046\0035\0047\0005\0058\0=\0059\4=\4:\0035\4;\0=\4<\0035\4=\0=\4>\0035\4@\0005\5?\0=\5A\0045\5B\0005\6C\0=\6\27\5=\5D\4=\4E\3B\1\2\1K\0\1\0\rrefactor\17smart_rename\1\0\1\17smart_rename\agR\1\0\1\venable\2\26highlight_definitions\1\0\0\1\0\1\venable\2\26context_commentstring\1\0\1\venable\2\14tree_docs\1\0\1\venable\2\frainbow\vcolors\1\b\0\0\f#bf616a\f#d08770\f#ebcb8b\f#a3be8c\f#88c0d0\f#5e81ac\f#b48ead\1\0\3\19max_file_lines\3Ë\a\18extended_mode\2\venable\2\15playground\16keybindings\1\0\n\14show_help\6?\14goto_node\t<cr>\vupdate\6R\21unfocus_language\6F\19focus_language\6f\28toggle_language_display\6I\27toggle_anonymous_nodes\6a\30toggle_injected_languages\6t\21toggle_hl_groups\6i\24toggle_query_editor\6o\1\0\3\15updatetime\3\25\20persist_queries\1\venable\2\16textobjects\tmove\22goto_previous_end\1\0\5\tgpiC\16@call.inner\bgpC\16@call.outer\bgpP\21@parameter.inner\tgpiF\20@function.inner\bgpF\20@function.outer\24goto_previous_start\1\0\5\tgpic\16@call.inner\bgpc\16@call.outer\bgpp\21@parameter.inner\tgpif\20@function.inner\bgpf\20@function.outer\18goto_next_end\1\0\5\bgnC\16@call.outer\bgnP\21@parameter.inner\tgniF\20@function.inner\bgnF\20@function.outer\tgniC\16@call.inner\20goto_next_start\1\0\5\tgnic\16@call.inner\bgnp\21@parameter.inner\bgnc\16@call.outer\tgnif\20@function.inner\bgnf\20@function.outer\1\0\2\venable\2\14set_jumps\2\vselect\1\0\0\1\0\f\bast\21@statement.outer\balp\16@loop.outer\aif\20@function.inner\aiB\17@block.inner\bilp\16@loop.inner\aaB\17@block.outer\bacm\19@comment.outer\6p\21@parameter.inner\bicd\23@conditional.inner\bacd\23@conditional.outer\aaf\20@function.outer\bisc\21@scopename.inner\1\0\1\venable\2\14autopairs\1\0\1\venable\2\17textsubjects\1\0\1\6,\23textsubjects-smart\1\0\1\venable\2\vindent\1\0\1\venable\2\26incremental_selection\fkeymaps\1\0\4\22scope_incremental\bgns\21node_incremental\bgnn\21node_decremental\bgnp\19init_selection\bgnn\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\1\0\1\rfiletype\rmarkdown\1\3\0\0\17src/parser.c\19src/scanner.cc\1\0\1\burl5https://github.com/ikatyang/tree-sitter-markdown\rmarkdown\17install_info\1\0\1\rfiletype\fhaskell\nfiles\1\3\0\0\17src/parser.c\19src/scanner.cc\1\0\1\burl7https://github.com/tree-sitter/tree-sitter-haskell\fhaskell\23get_parser_configs\28nvim-treesitter.parsers\1\2\0\0\vgcc-11\14compilers\28nvim-treesitter.install\frequire\nmacos\bhas\afn\bvim\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    commands = { "Octo" },
    config = { "\27LJ\2\nj\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\19default_remote\1\0\0\1\4\0\0\rupstream\nelken\vorigin\nsetup\tocto\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/opt/octo.nvim"
  },
  ["orgmode.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\forgmode\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/orgmode.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    commands = { "TSPlaygroundToggle" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/opt/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["project.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/project.nvim"
  },
  rnvimr = {
    config = { "\27LJ\2\nm\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0>HIGHLIGHT_STYLE=nord ranger --cmd=\"set draw_borders both\"\22rnvimr_ranger_cmd\6g\bvim\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/rnvimr"
  },
  ["shade.nvim"] = {
    config = { "\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\20overlay_opacity\0032\nsetup\nshade\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/shade.nvim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/sqlite.lua"
  },
  ["suda.vim"] = {
    commands = { "SudaWrite", "SudaRead" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/opt/suda.vim"
  },
  ["telescope-frecency.nvim"] = {
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\n˙\1\0\0\b\0\16\0\0306\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\v\0005\4\t\0005\5\a\0005\6\5\0009\a\4\0=\a\6\6=\6\b\5=\5\n\4=\4\f\3B\1\2\0016\1\0\0'\3\r\0B\1\2\0029\1\3\0014\3\0\0B\1\2\0016\1\0\0'\3\2\0B\1\2\0029\1\14\1'\3\15\0B\1\2\1K\0\1\0\rprojects\19load_extension\17project_nvim\rdefaults\1\0\0\rmappings\1\0\0\6i\1\0\0\n<esc>\1\0\0\nclose\nsetup\14telescope\22telescope.actions\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  undotree = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["unicode.vim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/unicode.vim"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/vim-endwise"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-speeddating"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/vim-speeddating"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-ultest"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/vim-ultest"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/vim-wordmotion"
  },
  ["which-key.nvim"] = {
    after = { "nvim-lspconfig" },
    loaded = true,
    only_config = true
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^dap"] = "nvim-dap",
  ["^telescope"] = "telescope.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\nM\0\2\n\0\1\0\0164\2\0\0006\3\0\0\18\5\0\0B\3\2\4H\6\1Ä<\a\6\2F\6\3\3R\6˝6\3\0\0\18\5\1\0B\3\2\4H\6\1Ä<\a\6\2F\6\3\3R\6˝L\2\2\0\npairs“\23\1\0\f\0^\0á\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0005\5\3\0=\5\5\4=\4\a\3B\1\2\0015\1\15\0005\2\b\0005\3\t\0=\3\n\0025\3\v\0=\3\f\0025\3\r\0=\3\14\2=\2\16\0015\2\17\0005\3\18\0=\3\19\2=\2\20\0015\2\21\0005\3\22\0=\3\23\0025\3\24\0=\3\25\0025\3\26\0=\3\14\0025\3\27\0=\3\28\0025\3\29\0=\3\30\0025\3\31\0=\3 \0025\3!\0=\3\"\0025\3#\0=\3$\2=\2\23\0015\2%\0005\3&\0=\3\16\0025\3'\0=\3(\0025\3)\0=\3\23\0025\3*\0=\3+\0025\3,\0=\3-\0025\3.\0=\3\"\2=\2-\0015\2/\0005\0030\0=\3\16\0025\0031\0=\3\14\0025\0032\0=\3\f\0025\0033\0=\0034\0025\0035\0=\3\28\0025\0036\0=\3 \0025\0037\0=\3\25\0025\0038\0=\0039\0025\3:\0=\3;\0025\3<\0=\3\30\2=\2=\0015\2>\0005\3?\0=\3\f\2=\2\f\0015\2@\0005\3A\0=\3B\0025\3C\0=\3(\0025\3D\0=\3\25\2=\2+\0015\2E\0=\2F\0015\2G\0=\2H\0015\2I\0=\2J\0015\2K\0=\2L\0015\2O\0005\3N\0005\4M\0=\4\"\3=\3-\0023\3P\0006\4Q\0009\4R\0049\4S\4'\6T\0B\4\2\2\15\0\4\0X\5\rÄ9\4+\0015\5Z\0006\6U\0009\6V\6'\bW\0006\tQ\0009\tR\t9\tX\t'\vY\0B\t\2\0A\6\1\2>\6\1\5=\5+\0049\4[\0\18\6\1\0005\a\\\0B\4\3\0019\4[\0\18\6\3\0\18\b\1\0\18\t\2\0B\6\3\0025\a]\0B\4\3\1K\0\1\0\1\0\2\vprefix\r<leader>\tmode\6v\1\0\1\vprefix\r<leader>\rregister\1\3\0\0\0\29Open directory in Finder\n%:p:h\vexpand+<cmd>silent !open -a Finder.app %s<CR>\vformat\vstring\nmacos\bhas\afn\bvim\0\1\0\0\1\0\0\1\3\0\0=<cmd>lua require('gitlinker').get_buf_range_url('v')<CR>#Yank link to current selection\6/\1\3\0\0!<cmd>Telescope live_grep<CR>\22Search in project\6.\1\3\0\0$<cmd>Telescope file_browser<CR>\14Find file\6,\1\3\0\0\31<cmd>Telescope buffers<CR>\18Switch buffer\f<space>\1\3\0\0}<cmd>lua if not pcall(require('telescope.builtin').git_files, {}) then require('telescope.builtin').find_files() end<CR>\25Find file in project\1\3\0\0\26<cmd>RnvimrToggle<CR>\vRanger\1\3\0\0q<cmd>lua require('toggleterm.terminal').Terminal:new({cmd = 'lazydocker', direction = 'float'}):toggle()<CR>\vDocker\6t\1\3\0\0\24<cmd>ToggleTerm<CR>\rTerminal\1\0\1\tname\tOpen\1\3\0\0!<cmd>:Telescope projects<CR>\19Switch Project\1\0\1\tname\rProjects\6h\1\3\0\0)<cmd>Gitsigns reset_buffer_index<CR>\23Reset buffer index\6u\1\3\0\0&<cmd>Gitsigns undo_stage_hunk<CR>\20Undo stage hunk\6R\1\3\0\0#<cmd>Gitsigns reset_buffer<CR>\25Reset current buffer\1\3\0\0!<cmd>Gitsigns reset_hunk<CR>\23Reset current hunk\1\3\0\0#<cmd>Gitsigns stage_buffer<CR>\25Stage current buffer\1\3\0\0!<cmd>Gitsigns stage_hunk<CR>\23Stage current hunk\6P\1\3\0\0#<cmd>Gitsigns preview_hunk<CR>\17Preview hunk\1\3\0\0 <cmd>Gitsigns prev_hunk<CR>\18Previous hunk\1\3\0\0 <cmd>Gitsigns next_hunk<CR>\14Next hunk\1\3\0\0!<cmd>Gitsigns blame_line<CR>\15Blame line\1\0\1\tname\tHunk\1\3\0\0=<cmd>lua require('gitlinker').get_buf_range_url('n')<CR>\30Yank link to current line\6g\1\3\0\0n<cmd>lua require('toggleterm.terminal').Terminal:new({cmd = 'lazygit', direction = 'float'}):toggle()<CR>\fLazygit\6o\1\3\0\0\21<cmd>GBrowse<CR>\20Open in browser\1\3\0\0\21<cmd>G fetch<CR>\nFetch\6D\1\3\0\0\21<cmd>GDelete<CR>!Delete current file from git\1\3\0\0004<cmd>lua require('neogit').open({'branch'})<CR>\22Open branch popup\1\0\1\tname\bGit\6Y\1\3\0\0&<cmd>let @+ = expand('%:~:.')<CR> Yank file path from project\6y\1\3\0\0$<cmd>let @+ = expand('%:p')<CR>\19Yank file path\6S\1\3\0\0\23<cmd>SudaWrite<CR>\15Sudo write\6U\1\3\0\0\22<cmd>SudaRead<CR>\14Sudo read\6s\1\3\0\0\15<cmd>w<CR>\14Save file\1\3\0\0\18<cmd>enew<CR>\rNew File\6r\1\3\0\0 <cmd>Telescope frecency<CR>\21Find Recent File\6f\1\3\0\0}<cmd>lua if not pcall(require('telescope.builtin').git_files, {}) then require('telescope.builtin').find_files() end<CR>\25Find file in project\1\0\1\tname\tFile\6e\6i\1\3\0\0'<cmd>e ~/.config/nvim/init.lua<CR>\rinit.lua\1\0\1\tname\15Edit Files\6b\1\0\0\6n\1\3\0\0\16<cmd>bn<CR>\16Next buffer\6p\1\3\0\0\16<cmd>bp<CR>\20Previous buffer\6d\1\3\0\0\21<cmd>Bdelete<CR>\16Kill buffer\1\0\1\tname\vBuffer\fplugins\1\0\0\rspelling\1\0\0\1\0\1\fenabled\2\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÁ\17\0\0\a\0F\0V6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\15\0\0\0X\1\5Ä6\0\4\0'\2\5\0B\0\2\0025\1\a\0=\1\6\0006\0\4\0'\2\b\0B\0\2\0029\0\t\0B\0\1\0025\1\14\0005\2\v\0005\3\f\0=\3\r\2=\2\15\1=\1\n\0005\1\19\0005\2\17\0005\3\18\0=\3\r\2=\2\15\1=\1\16\0006\1\4\0'\3\20\0B\1\2\0029\1\21\0015\3\22\0005\4\23\0=\4\24\0035\4\25\0005\5\26\0=\5\27\4=\4\28\0035\4\29\0=\4\30\0035\4\31\0005\5 \0=\5\27\4=\4!\0035\4\"\0=\4#\0035\4&\0005\5$\0005\6%\0=\6\27\5=\5'\0045\5(\0005\6)\0=\6*\0055\6+\0=\6,\0055\6-\0=\6.\0055\6/\0=\0060\5=\0051\4=\0042\0035\0043\0005\0054\0=\0055\4=\0046\0035\0047\0005\0058\0=\0059\4=\4:\0035\4;\0=\4<\0035\4=\0=\4>\0035\4@\0005\5?\0=\5A\0045\5B\0005\6C\0=\6\27\5=\5D\4=\4E\3B\1\2\1K\0\1\0\rrefactor\17smart_rename\1\0\1\17smart_rename\agR\1\0\1\venable\2\26highlight_definitions\1\0\0\1\0\1\venable\2\26context_commentstring\1\0\1\venable\2\14tree_docs\1\0\1\venable\2\frainbow\vcolors\1\b\0\0\f#bf616a\f#d08770\f#ebcb8b\f#a3be8c\f#88c0d0\f#5e81ac\f#b48ead\1\0\3\19max_file_lines\3Ë\a\18extended_mode\2\venable\2\15playground\16keybindings\1\0\n\14show_help\6?\14goto_node\t<cr>\vupdate\6R\21unfocus_language\6F\19focus_language\6f\28toggle_language_display\6I\27toggle_anonymous_nodes\6a\30toggle_injected_languages\6t\21toggle_hl_groups\6i\24toggle_query_editor\6o\1\0\3\15updatetime\3\25\20persist_queries\1\venable\2\16textobjects\tmove\22goto_previous_end\1\0\5\tgpiC\16@call.inner\bgpC\16@call.outer\bgpP\21@parameter.inner\tgpiF\20@function.inner\bgpF\20@function.outer\24goto_previous_start\1\0\5\tgpic\16@call.inner\bgpc\16@call.outer\bgpp\21@parameter.inner\tgpif\20@function.inner\bgpf\20@function.outer\18goto_next_end\1\0\5\bgnC\16@call.outer\bgnP\21@parameter.inner\tgniF\20@function.inner\bgnF\20@function.outer\tgniC\16@call.inner\20goto_next_start\1\0\5\tgnic\16@call.inner\bgnp\21@parameter.inner\bgnc\16@call.outer\tgnif\20@function.inner\bgnf\20@function.outer\1\0\2\venable\2\14set_jumps\2\vselect\1\0\0\1\0\f\bast\21@statement.outer\balp\16@loop.outer\aif\20@function.inner\aiB\17@block.inner\bilp\16@loop.inner\aaB\17@block.outer\bacm\19@comment.outer\6p\21@parameter.inner\bicd\23@conditional.inner\bacd\23@conditional.outer\aaf\20@function.outer\bisc\21@scopename.inner\1\0\1\venable\2\14autopairs\1\0\1\venable\2\17textsubjects\1\0\1\6,\23textsubjects-smart\1\0\1\venable\2\vindent\1\0\1\venable\2\26incremental_selection\fkeymaps\1\0\4\22scope_incremental\bgns\21node_incremental\bgnn\21node_decremental\bgnp\19init_selection\bgnn\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\1\0\1\rfiletype\rmarkdown\1\3\0\0\17src/parser.c\19src/scanner.cc\1\0\1\burl5https://github.com/ikatyang/tree-sitter-markdown\rmarkdown\17install_info\1\0\1\rfiletype\fhaskell\nfiles\1\3\0\0\17src/parser.c\19src/scanner.cc\1\0\1\burl7https://github.com/tree-sitter/tree-sitter-haskell\fhaskell\23get_parser_configs\28nvim-treesitter.parsers\1\2\0\0\vgcc-11\14compilers\28nvim-treesitter.install\frequire\nmacos\bhas\afn\bvim\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n†\1\0\0\b\0\6\1\31)\0\0\0)\1\1\0006\2\0\0009\2\1\0029\2\2\2'\4\3\0B\2\2\2)\3\1\0M\1\vÄ6\5\0\0009\5\1\0059\5\4\5\18\a\4\0B\5\2\2\15\0\5\0X\6\2Ä\a\5\5\0X\6\1Ä\22\0\0\0O\1ı)\1\1\0\1\1\0\0X\1\5Ä6\1\0\0009\1\1\0019\1\2\1D\1\1\0X\1\2Ä'\1\5\0L\1\2\0K\0\1\0\5\16win_gettype\6$\nwinnr\afn\bvim\2Á\3\1\0\a\0\26\0&3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\t\0005\4\4\0005\5\5\0=\5\6\0045\5\a\0=\5\b\4=\4\n\0035\4\f\0004\5\3\0>\0\1\0055\6\v\0>\6\2\5=\5\r\4=\4\14\0035\4\15\0004\5\3\0>\0\1\5=\5\16\0044\5\0\0=\5\17\0045\5\18\0=\5\r\0045\5\19\0=\5\20\0044\5\0\0=\5\21\0044\5\0\0=\5\22\4=\4\23\0035\4\24\0=\4\25\3B\1\2\1K\0\1\0\15extensions\1\4\0\0\rquickfix\15toggleterm\rfugitive\22inactive_sections\14lualine_z\14lualine_y\14lualine_x\1\2\0\0\rlocation\1\2\0\0\rfilename\14lualine_b\14lualine_a\1\0\0\rsections\14lualine_c\1\0\0\1\2\2\0\rfilename\tpath\3\1\16file_status\2\foptions\1\0\0\25component_separators\1\0\2\tleft\b‚ï≤\nright\b‚ï±\23section_separators\1\0\2\tleft\bÓÇ∏\nright\bÓÇ∫\1\0\1\ntheme\tnord\nsetup\flualine\frequire\0\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: markdown-preview.nvim
time([[Config for markdown-preview.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\ffirefox\17mkdp_browser\6g\bvim\0", "config", "markdown-preview.nvim")
time([[Config for markdown-preview.nvim]], false)
-- Config for: neogit
time([[Config for neogit]], true)
try_loadstring("\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0", "config", "neogit")
time([[Config for neogit]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireö\1\0\1\3\2\4\0\21-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\vÄ-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4Ä-\1\1\0009\1\3\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\1¿\19expand_or_jump\23expand_or_jumpable\21select_next_item\fvisibleé\1\0\1\4\2\4\0\23-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\rÄ-\1\1\0009\1\2\1)\3ˇˇB\1\2\2\15\0\1\0X\2\5Ä-\1\1\0009\1\3\1)\3ˇˇB\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\1¿\tjump\rjumpable\21select_prev_item\fvisibleË\1\0\2\5\0\n\0\0176\2\1\0'\4\2\0B\2\2\0029\2\3\0029\2\4\0029\3\0\0018\2\3\2'\3\5\0009\4\0\1&\2\4\2=\2\0\0015\2\a\0009\3\b\0009\3\t\0038\2\3\2=\2\6\1L\1\2\0\tname\vsource\1\0\6\rnvim_lua\n[Lua]\fluasnip\14[LuaSnip]\18latex_symbols\f[Latex]\tpath\v[Path]\rnvim_lsp\n[LSP]\vbuffer\r[Buffer]\tmenu\6 \fdefault\fpresets\flspkind\frequire\tkindÿ\5\1\0\n\0/\0P6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0026\1\0\0'\3\4\0B\1\2\0029\2\5\0005\4\f\0004\5\a\0005\6\6\0>\6\1\0055\6\a\0>\6\2\0055\6\b\0>\6\3\0055\6\t\0>\6\4\0055\6\n\0>\6\5\0055\6\v\0>\6\6\5=\5\r\0045\5\15\0003\6\14\0=\6\16\5=\5\17\0045\5\20\0009\6\18\0009\6\19\6B\6\1\2=\6\21\0059\6\18\0009\6\22\6B\6\1\2=\6\23\0059\6\18\0009\6\24\6)\b¸ˇB\6\2\2=\6\25\0059\6\18\0009\6\24\6)\b\4\0B\6\2\2=\6\26\0059\6\18\0009\6\27\6B\6\1\2=\6\28\0059\6\18\0009\6\29\6B\6\1\2=\6\30\0059\6\18\0009\6\31\0065\b\"\0009\t \0009\t!\t=\t#\bB\6\2\2=\6$\0053\6%\0=\6&\0053\6'\0=\6(\5=\5\18\0045\5*\0003\6)\0=\6+\5=\5,\0045\5-\0=\5.\4B\2\2\0012\0\0ÄK\0\1\0\18documentation\1\0\1\vborder\vsingle\15formatting\vformat\1\0\0\0\f<S-Tab>\0\n<Tab>\0\t<CR>\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\n<C-g>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-d>\16scroll_docs\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\forgmode\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lua\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\nsetup\fluasnip\bcmp\tinit\flspkind\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nord.nvim
time([[Config for nord.nvim]], true)
try_loadstring("\27LJ\2\n¶\1\0\0\3\0\a\0\0226\0\0\0009\0\1\0+\1\1\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\1\0009\0\4\0\14\0\0\0X\0\bÄ6\0\0\0009\0\5\0'\2\6\0B\0\2\0016\0\0\0009\0\1\0+\1\2\0=\1\4\0K\0\1\0\21colorscheme nord\bcmd\21colourscheme_set\17nord_borders\18nord_contrast\6g\bvim\0", "config", "nord.nvim")
time([[Config for nord.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: firenvim
time([[Config for firenvim]], true)
try_loadstring("\27LJ\2\n¶\4\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0Ü\4                au BufEnter github.com_*.txt set filetype=markdown\n                au BufEnter reddit.com_*.txt set filetype=markdown\n                let g:firenvim_config = { \"globalSettings\": { \"alt\": \"all\", }, \"localSettings\": { \".*\": { \"cmdline\": \"neovim\", \"content\": \"text\", \"priority\": 0, \"selector\": \"textarea\", \"takeover\": \"always\", }, } }\n                let fc = g:firenvim_config[\"localSettings\"]\n                let fc[\"https?://mail.google.com/\"] = { \"takeover\": \"never\", \"priority\": 1 }\n            \bcmd\bvim\0", "config", "firenvim")
time([[Config for firenvim]], false)
-- Config for: gitlinker.nvim
time([[Config for gitlinker.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14gitlinker\frequire\0", "config", "gitlinker.nvim")
time([[Config for gitlinker.nvim]], false)
-- Config for: ale
time([[Config for ale]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "ale")
time([[Config for ale]], false)
-- Config for: orgmode.nvim
time([[Config for orgmode.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\forgmode\frequire\0", "config", "orgmode.nvim")
time([[Config for orgmode.nvim]], false)
-- Config for: shade.nvim
time([[Config for shade.nvim]], true)
try_loadstring("\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\20overlay_opacity\0032\nsetup\nshade\frequire\0", "config", "shade.nvim")
time([[Config for shade.nvim]], false)
-- Config for: nvim-neoclip.lua
time([[Config for nvim-neoclip.lua]], true)
try_loadstring("\27LJ\2\nW\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\30enable_persistant_history\2\nsetup\fneoclip\frequire\0", "config", "nvim-neoclip.lua")
time([[Config for nvim-neoclip.lua]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nè\4\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\21context_patterns\1\17\0\0\ntable\nclass\rfunction\vmethod\b^if\nwhile\bfor\twith\17func_literal\nblock\btry\vexcept\18argument_list\vobject\15dictionary\felement\20buftype_exclude\1\4\0\0\thelp\rterminal\vnofile\21filetype_exclude\1\0\3\24max_indent_increase\3\1\25show_current_context\2\19use_treesitter\2\1\22\0\0\rstartify\14dashboard\16dotooagenda\blog\rfugitive\14gitcommit\vpacker\fvimwiki\rmarkdown\tjson\btxt\nvista\thelp\ftodoist\rNvimTree\rpeekaboo\bgit\20TelescopePrompt\rundotree\24flutterToolsOutline\5\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nM\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\fkeymaps\1\0\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\n2\0\0\4\0\3\0\0066\0\0\0006\1\2\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\frequire\vnotify\bvim\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\nï\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\3\20separator_style\nslant\27always_show_bufferline\1\16diagnostics\rnvim_lsp\nsetup\15bufferline\frequire\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: telescope-frecency.nvim
time([[Config for telescope-frecency.nvim]], true)
try_loadstring("\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0", "config", "telescope-frecency.nvim")
time([[Config for telescope-frecency.nvim]], false)
-- Config for: nvim-toggleterm.lua
time([[Config for nvim-toggleterm.lua]], true)
try_loadstring("\27LJ\2\n®\4\0\0\6\0\26\0/6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\3=\3\6\0025\3\a\0005\4\b\0=\4\t\3=\3\n\2B\0\2\0016\0\4\0009\0\v\0009\0\f\0'\2\r\0'\3\14\0'\4\15\0005\5\16\0B\0\5\0016\0\4\0009\0\v\0009\0\f\0'\2\r\0'\3\17\0'\4\18\0005\5\19\0B\0\5\0016\0\4\0009\0\v\0009\0\f\0'\2\r\0'\3\20\0'\4\21\0005\5\22\0B\0\5\0016\0\4\0009\0\v\0009\0\f\0'\2\r\0'\3\23\0'\4\24\0005\5\25\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>l\n<C-l>\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>k\n<C-k>\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>j\n<C-j>\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>h\n<C-h>\6t\20nvim_set_keymap\bapi\15float_opts\15highlights\1\0\2\vborder\vNormal\15background\vNormal\1\0\2\vborder\vdouble\rwinblend\3\0\nshell\6o\bvim\1\0\2\14direction\15horizontal\20shade_terminals\1\nsetup\15toggleterm\frequire\0", "config", "nvim-toggleterm.lua")
time([[Config for nvim-toggleterm.lua]], false)
-- Config for: rnvimr
time([[Config for rnvimr]], true)
try_loadstring("\27LJ\2\nm\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0>HIGHLIGHT_STYLE=nord ranger --cmd=\"set draw_borders both\"\22rnvimr_ranger_cmd\6g\bvim\0", "config", "rnvimr")
time([[Config for rnvimr]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-lspconfig ]]

-- Config for: nvim-lspconfig
try_loadstring("\27LJ\2\n®\3\0\0\6\0\17\0\0255\0\0\0005\1\1\0=\1\2\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\0015\2\b\0=\2\t\1=\1\n\0004\1\0\0=\1\v\0006\1\f\0'\3\r\0B\1\2\0029\1\14\0016\3\f\0'\5\15\0B\3\2\0029\3\16\3\18\5\0\0B\3\2\0A\1\0\1K\0\1\0\17get_dropdown\21telescope.themes\21lsp_code_actions\22telescope.builtin\frequire\vborder\16borderchars\fpreview\1\t\0\0\b‚îÄ\b‚îÇ\b‚îÄ\b‚îÇ\b‚ï≠\b‚ïÆ\b‚ïØ\b‚ï∞\fresults\1\t\0\0\b‚îÄ\b‚îÇ\b‚îÄ\b‚îÇ\b‚îú\b‚î§\b‚ïØ\b‚ï∞\vprompt\1\0\0\1\t\0\0\b‚îÄ\b‚îÇ\6 \b‚îÇ\b‚ï≠\b‚ïÆ\b‚îÇ\b‚îÇ\18layout_config\1\0\3\vheight\3\f\nwidth\3P\20prompt_position\btop\1\0\3\17shorten_path\1\14previewer\1\rwinblend\3\15A\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1¿\24nvim_buf_set_option\bapi\bvimø\17\1\2\v\1A\0t6\2\0\0'\4\1\0B\2\2\0029\2\2\0025\4\3\0005\5\4\0=\5\5\4\18\5\1\0B\2\3\0013\2\6\0006\3\a\0009\3\b\0039\3\t\0036\4\a\0009\4\b\0049\4\v\0046\6\a\0009\6\b\0069\6\t\0069\6\f\0065\a\r\0B\4\3\2=\4\n\0036\3\a\0009\3\b\0039\3\t\0036\4\a\0009\4\b\0049\4\v\0046\6\a\0009\6\b\0069\6\t\0069\6\f\0065\a\15\0B\4\3\2=\4\14\3\18\3\2\0'\5\16\0'\6\17\0B\3\3\0015\3\18\0=\1\19\3-\4\0\0009\4\20\0045\6\22\0005\a\21\0=\a\23\0065\a\25\0005\b\24\0=\b\26\a5\b\27\0=\b\28\a5\b\29\0=\b\30\a5\b\31\0=\b \a=\a!\0065\a/\0005\b\"\0005\t#\0=\t$\b5\t%\0=\t&\b5\t'\0005\n(\0=\n$\t5\n)\0=\n \t5\n*\0=\n+\t=\t,\b5\t-\0=\t.\b=\b&\a5\b0\0=\b1\a5\b2\0=\b3\a=\a4\6\18\a\3\0B\4\3\0019\0045\0009\0046\4\15\0\4\0X\5\bÄ-\4\0\0009\4\20\0045\0068\0005\a7\0=\a9\6\18\a\3\0B\4\3\1X\4\vÄ9\0045\0009\4:\4\15\0\4\0X\5\aÄ-\4\0\0009\4\20\0045\6<\0005\a;\0=\a9\6\18\a\3\0B\4\3\0019\0045\0009\4=\4\15\0\4\0X\5\6Ä6\4\a\0009\4>\0049\4?\4'\6@\0+\a\1\0B\4\3\0012\0\0ÄK\0\1\0\0¿¡\2                    augroup lsp_document_highlight\n                    autocmd! * <buffer>\n                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n                    augroup END\n                        \14nvim_exec\bapi\23document_highlight\1\0\0\1\3\0\0000<cmd>lua vim.lsp.buf.range_formatting()<CR>\25Format buffer/region\30document_range_formatting\15<leader>cf\1\0\0\1\3\0\0*<cmd>lua vim.lsp.buf.formatting()<CR>\18Format buffer\24document_formatting\26resolved_capabilities\r<leader>\6]\1\3\0\0000<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\23Jump to next error\6[\1\3\0\0000<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\27Jump to previous error\1\0\0\6x\1\3\0\0O<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = 'single'})<CR>\30Show diagnostics for line\6w\6l\1\3\0\0K<cmd> lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>\27List workspace folders\1\3\0\0007<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>\28Remove workspace folder\1\3\0\0004<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>\25Add workspace folder\1\0\1\tname\15Workspaces\6c\1\3\0\0\18<cmd>Make<CR>\fCompile\6a\1\3\0\0(<cmd>lua TelescopeCodeActions()<CR>\21LSP Code Actions\1\0\1\tname\tCode\6g\6r\1\3\0\0*<cmd>lua vim.lsp.buf.references()<CR>\19LSP references\6i\1\3\0\0.<cmd>lua vim.lsp.buf.implementation()<CR>\23LSP implementation\6D\1\3\0\0+<cmd>lua vim.lsp.buf.declaration()<CR>\20LSP declaration\6d\1\0\0\1\3\0\0*<cmd>lua vim.lsp.buf.definition()<CR>\19LSP definition\6K\1\0\0\1\3\0\0%<cmd>lua vim.lsp.buf.hover()<CR>\"Show documentation for symbol\rregister\vbuffer\1\0\2\vsilent\2\fnoremap\2\27v:lua.vim.lsp.omnifunc\romnifunc\1\0\1\vborder\vsingle\31textDocument/signatureHelp\1\0\1\vborder\vsingle\nhover\twith\23textDocument/hover\rhandlers\blsp\bvim\0\17handler_opts\1\0\1\vborder\vsingle\1\0\1\tbind\2\14on_attach\18lsp_signature\frequire¥\1\0\1\6\3\n\0\0195\1\0\0-\2\0\0=\2\1\1-\2\1\0=\2\2\0019\2\3\0\a\2\4\0X\2\2Ä-\2\2\0=\2\5\1\18\4\0\0009\2\6\0\18\5\1\0B\2\3\0016\2\a\0009\2\b\2'\4\t\0B\2\2\1K\0\1\0\2Ä\1¿\4¿\29do User LspAttachBuffers\bcmd\bvim\nsetup\rsettings\16sumneko_lua\tname\14on_attach\17capabilities\1\0\0€\4\1\0\v\0'\0?6\0\0\0'\2\1\0B\0\2\0023\1\2\0007\1\3\0003\1\4\0006\2\5\0009\2\6\0029\2\a\0029\2\b\2B\2\1\0026\3\0\0'\5\t\0B\3\2\0029\3\n\3\18\5\2\0B\3\2\2\18\2\3\0006\3\5\0009\3\v\0036\5\f\0009\5\r\5'\6\14\0B\3\3\0026\4\15\0009\4\16\4\18\6\3\0'\a\17\0B\4\3\0016\4\15\0009\4\16\4\18\6\3\0'\a\18\0B\4\3\0015\4\20\0005\5\19\0=\5\21\0045\5\23\0005\6\22\0=\3\r\6=\6\24\0055\6\26\0005\a\25\0=\a\27\6=\6\28\0055\6 \0006\a\5\0009\a\29\a9\a\30\a'\t\31\0+\n\2\0B\a\3\2=\a!\6=\6\"\5=\5#\0046\5\0\0'\a$\0B\5\2\0029\6%\0053\b&\0B\6\2\0012\0\0ÄK\0\1\0\0\20on_server_ready\23nvim-lsp-installer\bLua\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\16diagnostics\fglobals\1\0\0\1\2\0\0\bvim\fruntime\1\0\0\1\0\1\fversion\vLuaJIT\14filetypes\1\0\0\1\2\0\0\blua\19lua/?/init.lua\14lua/?.lua\vinsert\ntable\6;\tpath\fpackage\nsplit\24update_capabilities\17cmp_nvim_lsp\29make_client_capabilities\rprotocol\blsp\bvim\0\25TelescopeCodeActions\0\14which-key\frequire\0", "config", "nvim-lspconfig")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Octo lua require("packer.load")({'octo.nvim'}, { cmd = "Octo", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSPlaygroundToggle lua require("packer.load")({'playground'}, { cmd = "TSPlaygroundToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIInstall lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIInstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIUninstall lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIUninstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIList lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIList", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SudaWrite lua require("packer.load")({'suda.vim'}, { cmd = "SudaWrite", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SudaRead lua require("packer.load")({'suda.vim'}, { cmd = "SudaRead", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
