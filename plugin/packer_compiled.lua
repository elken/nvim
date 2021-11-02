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
local package_path_str = "/home/elken/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/elken/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/elken/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/elken/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/elken/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
    config = { "\27LJ\2\2ï\1\0\0\n\0\6\0\0186\0\0\0'\1\1\0B\0\2\0026\1\0\0'\2\2\0B\1\2\0029\1\3\0016\2\4\0\18\3\1\0B\2\2\4H\5\4Ä9\a\5\0\18\b\5\0004\t\0\0B\a\3\1F\5\3\3R\5˙K\0\1\0\vconfig\npairs\14debuggers\31dap-install.debuggers_list\16dap-install\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/elken/.local/share/nvim/site/pack/packer/opt/DAPInstall.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ale = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/bufdelete.nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\2ï\1\0\0\3\0\6\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\1B\0\2\1K\0\1\0\foptions\1\0\0\1\0\3\27always_show_bufferline\1\20separator_style\nslant\16diagnostics\rnvim_lsp\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/cmp-emoji"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["detect-language.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/detect-language.nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/diffview.nvim"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/filetype.nvim"
  },
  firenvim = {
    config = { "\27LJ\2\2ˇ\4\0\0\2\0\3\0\0056\0\0\0009\0\1\0'\1\2\0B\0\2\1K\0\1\0ﬂ\4                au BufEnter github.com_*.txt set filetype=markdown\n                au BufEnter reddit.com_*.txt set filetype=markdown\n                let g:firenvim_config = { \"globalSettings\": { \"alt\": \"all\", }, \"localSettings\": { \".*\": { \"cmdline\": \"neovim\", \"content\": \"text\", \"priority\": 0, \"selector\": \"textarea\", \"takeover\": \"always\", }, } }\n                let fc = g:firenvim_config[\"localSettings\"]\n                let fc[\"https?://mail.google.com/\"] = { \"takeover\": \"never\", \"priority\": 1 }\n                let fc[\"https?://discord.com/\"] = { \"takeover\": \"never\", \"priority\": 1 }\n            \bcmd\bvim\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  ["github-notifications.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/github-notifications.nvim"
  },
  ["gitlinker.nvim"] = {
    config = { "\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14gitlinker\frequire\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/gitlinker.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\2M\0\0\3\0\5\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0004\2\0\0=\2\4\1B\0\2\1K\0\1\0\fkeymaps\1\0\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["headlines.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/headlines.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\2è\4\0\0\3\0\n\0\r6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\0015\2\b\0=\2\t\1B\0\2\1K\0\1\0\21context_patterns\1\17\0\0\ntable\nclass\rfunction\vmethod\b^if\nwhile\bfor\twith\17func_literal\nblock\btry\vexcept\18argument_list\vobject\15dictionary\felement\20buftype_exclude\1\4\0\0\thelp\rterminal\vnofile\21filetype_exclude\1\0\3\25show_current_context\2\19use_treesitter\2\24max_indent_increase\3\1\1\22\0\0\rstartify\14dashboard\16dotooagenda\blog\rfugitive\14gitcommit\vpacker\fvimwiki\rmarkdown\tjson\btxt\nvista\thelp\ftodoist\rNvimTree\rpeekaboo\bgit\20TelescopePrompt\rundotree\24flutterToolsOutline\5\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lightspeed.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/lightspeed.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine-lsp-progress"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/lualine-lsp-progress"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\2<\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19config.lualine\frequire\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    config = { "\27LJ\2\0026\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\ffirefox\17mkdp_browser\6g\bvim\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  neogit = {
    config = { "\27LJ\2\2]\0\0\3\0\6\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\1B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/neogit"
  },
  ["nord.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nord.nvim"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-bqf"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\0028\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15config.cmp\frequire\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-ui" },
    config = { "\27LJ\2\2b\0\2\5\0\4\0\14\18\2\0\0005\3\0\0009\4\1\1\14\0\4\0X\5\1Ä'\4\2\0=\4\1\0039\4\3\1\14\0\4\0X\5\1Ä)\4ò\31=\4\3\3B\2\2\1K\0\1\0\tport\014127.0.0.1\thost\1\0\1\ttype\vserver•\6\1\0\4\0\v\0\0166\0\0\0'\1\1\0B\0\2\0029\1\2\0004\2\3\0005\3\4\0>\3\1\2=\2\3\0019\1\5\0003\2\a\0=\2\6\0016\1\b\0009\1\t\1'\2\n\0B\1\2\1K\0\1\0Ë\4            nnoremap <silent> <F5> :lua require'dap'.continue()<CR>\n            nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>\n            nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>\n            nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>\n            nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>\n            nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>\n            nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>\n        \bcmd\bvim\0\tnlua\radapters\1\0\3\ttype\tnlua\tname&Attach to running Neovim instance\frequest\vattach\blua\19configurations\bdap\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/elken/.local/share/nvim/site/pack/packer/opt/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/elken/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\2>\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21config.lspconfig\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/elken/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-neoclip.lua"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-neoclip.lua"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\0022\0\0\3\0\3\0\0066\0\0\0006\1\2\0'\2\1\0B\1\2\2=\1\1\0K\0\1\0\frequire\vnotify\bvim\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-notify"
  },
  ["nvim-toggleterm.lua"] = {
    config = { "\27LJ\2\2®\4\0\0\5\0\26\0/6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0006\2\4\0009\2\5\0029\2\6\2=\2\6\0015\2\a\0005\3\b\0=\3\t\2=\2\n\1B\0\2\0016\0\4\0009\0\v\0009\0\f\0'\1\r\0'\2\14\0'\3\15\0005\4\16\0B\0\5\0016\0\4\0009\0\v\0009\0\f\0'\1\r\0'\2\17\0'\3\18\0005\4\19\0B\0\5\0016\0\4\0009\0\v\0009\0\f\0'\1\r\0'\2\20\0'\3\21\0005\4\22\0B\0\5\0016\0\4\0009\0\v\0009\0\f\0'\1\r\0'\2\23\0'\3\24\0005\4\25\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>l\n<C-l>\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>k\n<C-k>\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>j\n<C-j>\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>h\n<C-h>\6t\20nvim_set_keymap\bapi\15float_opts\15highlights\1\0\2\15background\vNormal\vborder\vNormal\1\0\2\rwinblend\3\0\vborder\vdouble\nshell\6o\bvim\1\0\2\14direction\15horizontal\20shade_terminals\2\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\2;\0\0\2\0\3\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0004\1\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\2?\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22config.treesitter\frequire\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    commands = { "Octo" },
    config = { "\27LJ\2\2j\0\0\3\0\6\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\1B\0\2\1K\0\1\0\19default_remote\1\0\0\1\4\0\0\rupstream\nelken\vorigin\nsetup\tocto\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/elken/.local/share/nvim/site/pack/packer/opt/octo.nvim"
  },
  ["one-small-step-for-vimkind"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/one-small-step-for-vimkind"
  },
  ["org-bullets.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/org-bullets.nvim"
  },
  ["orgmode.nvim"] = {
    config = { "\27LJ\2\2˜\1\0\0\3\0\v\0\0226\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\1B\0\2\0016\0\0\0'\1\6\0B\0\2\0029\0\2\0005\1\b\0005\2\a\0=\2\t\1B\0\2\0016\0\0\0'\1\n\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\14headlines\fsymbols\1\0\0\1\2\0\0\b‚Ä∫\16org-bullets\21org_agenda_files\1\0\1\27org_default_notes_file\30~/Nextcloud/org/Notes.org\1\2\0\0\20~/Nextcloud/org\nsetup\forgmode\frequire\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/orgmode.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["project.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/project.nvim"
  },
  rnvimr = {
    config = { "\27LJ\2\2m\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0>HIGHLIGHT_STYLE=nord ranger --cmd=\"set draw_borders both\"\22rnvimr_ranger_cmd\6g\bvim\0" },
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/rnvimr"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/sqlite.lua"
  },
  ["suda.vim"] = {
    commands = { "SudaWrite", "SudaRead" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/elken/.local/share/nvim/site/pack/packer/opt/suda.vim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\2>\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21config.telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/elken/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  undotree = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["unicode.vim"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/unicode.vim"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/vim-endwise"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-speeddating"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/vim-speeddating"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-ultest"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/vim-ultest"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/home/elken/.local/share/nvim/site/pack/packer/start/vim-wordmotion"
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

-- Config for: nvim-toggleterm.lua
time([[Config for nvim-toggleterm.lua]], true)
try_loadstring("\27LJ\2\2®\4\0\0\5\0\26\0/6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0006\2\4\0009\2\5\0029\2\6\2=\2\6\0015\2\a\0005\3\b\0=\3\t\2=\2\n\1B\0\2\0016\0\4\0009\0\v\0009\0\f\0'\1\r\0'\2\14\0'\3\15\0005\4\16\0B\0\5\0016\0\4\0009\0\v\0009\0\f\0'\1\r\0'\2\17\0'\3\18\0005\4\19\0B\0\5\0016\0\4\0009\0\v\0009\0\f\0'\1\r\0'\2\20\0'\3\21\0005\4\22\0B\0\5\0016\0\4\0009\0\v\0009\0\f\0'\1\r\0'\2\23\0'\3\24\0005\4\25\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>l\n<C-l>\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>k\n<C-k>\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>j\n<C-j>\1\0\2\vsilent\2\fnoremap\2\21<C-\\><C-n><C-w>h\n<C-h>\6t\20nvim_set_keymap\bapi\15float_opts\15highlights\1\0\2\15background\vNormal\vborder\vNormal\1\0\2\rwinblend\3\0\vborder\vdouble\nshell\6o\bvim\1\0\2\14direction\15horizontal\20shade_terminals\2\nsetup\15toggleterm\frequire\0", "config", "nvim-toggleterm.lua")
time([[Config for nvim-toggleterm.lua]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\0022\0\0\3\0\3\0\0066\0\0\0006\1\2\0'\2\1\0B\1\2\2=\1\1\0K\0\1\0\frequire\vnotify\bvim\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\0028\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15config.cmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\2è\4\0\0\3\0\n\0\r6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\0015\2\b\0=\2\t\1B\0\2\1K\0\1\0\21context_patterns\1\17\0\0\ntable\nclass\rfunction\vmethod\b^if\nwhile\bfor\twith\17func_literal\nblock\btry\vexcept\18argument_list\vobject\15dictionary\felement\20buftype_exclude\1\4\0\0\thelp\rterminal\vnofile\21filetype_exclude\1\0\3\25show_current_context\2\19use_treesitter\2\24max_indent_increase\3\1\1\22\0\0\rstartify\14dashboard\16dotooagenda\blog\rfugitive\14gitcommit\vpacker\fvimwiki\rmarkdown\tjson\btxt\nvista\thelp\ftodoist\rNvimTree\rpeekaboo\bgit\20TelescopePrompt\rundotree\24flutterToolsOutline\5\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: markdown-preview.nvim
time([[Config for markdown-preview.nvim]], true)
try_loadstring("\27LJ\2\0026\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\ffirefox\17mkdp_browser\6g\bvim\0", "config", "markdown-preview.nvim")
time([[Config for markdown-preview.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: neogit
time([[Config for neogit]], true)
try_loadstring("\27LJ\2\2]\0\0\3\0\6\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\1B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0", "config", "neogit")
time([[Config for neogit]], false)
-- Config for: gitlinker.nvim
time([[Config for gitlinker.nvim]], true)
try_loadstring("\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14gitlinker\frequire\0", "config", "gitlinker.nvim")
time([[Config for gitlinker.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\2>\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21config.which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\2<\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19config.lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: orgmode.nvim
time([[Config for orgmode.nvim]], true)
try_loadstring("\27LJ\2\2˜\1\0\0\3\0\v\0\0226\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\1B\0\2\0016\0\0\0'\1\6\0B\0\2\0029\0\2\0005\1\b\0005\2\a\0=\2\t\1B\0\2\0016\0\0\0'\1\n\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\14headlines\fsymbols\1\0\0\1\2\0\0\b‚Ä∫\16org-bullets\21org_agenda_files\1\0\1\27org_default_notes_file\30~/Nextcloud/org/Notes.org\1\2\0\0\20~/Nextcloud/org\nsetup\forgmode\frequire\0", "config", "orgmode.nvim")
time([[Config for orgmode.nvim]], false)
-- Config for: firenvim
time([[Config for firenvim]], true)
try_loadstring("\27LJ\2\2ˇ\4\0\0\2\0\3\0\0056\0\0\0009\0\1\0'\1\2\0B\0\2\1K\0\1\0ﬂ\4                au BufEnter github.com_*.txt set filetype=markdown\n                au BufEnter reddit.com_*.txt set filetype=markdown\n                let g:firenvim_config = { \"globalSettings\": { \"alt\": \"all\", }, \"localSettings\": { \".*\": { \"cmdline\": \"neovim\", \"content\": \"text\", \"priority\": 0, \"selector\": \"textarea\", \"takeover\": \"always\", }, } }\n                let fc = g:firenvim_config[\"localSettings\"]\n                let fc[\"https?://mail.google.com/\"] = { \"takeover\": \"never\", \"priority\": 1 }\n                let fc[\"https?://discord.com/\"] = { \"takeover\": \"never\", \"priority\": 1 }\n            \bcmd\bvim\0", "config", "firenvim")
time([[Config for firenvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\2;\0\0\2\0\3\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0004\1\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\2ï\1\0\0\3\0\6\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\1B\0\2\1K\0\1\0\foptions\1\0\0\1\0\3\27always_show_bufferline\1\20separator_style\nslant\16diagnostics\rnvim_lsp\nsetup\15bufferline\frequire\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: rnvimr
time([[Config for rnvimr]], true)
try_loadstring("\27LJ\2\2m\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0>HIGHLIGHT_STYLE=nord ranger --cmd=\"set draw_borders both\"\22rnvimr_ranger_cmd\6g\bvim\0", "config", "rnvimr")
time([[Config for rnvimr]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\2?\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22config.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\2M\0\0\3\0\5\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0004\2\0\0=\2\4\1B\0\2\1K\0\1\0\fkeymaps\1\0\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-lspconfig ]]

-- Config for: nvim-lspconfig
try_loadstring("\27LJ\2\2>\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21config.lspconfig\frequire\0", "config", "nvim-lspconfig")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIInstall lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIInstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Octo lua require("packer.load")({'octo.nvim'}, { cmd = "Octo", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIList lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIList", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SudaRead lua require("packer.load")({'suda.vim'}, { cmd = "SudaRead", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SudaWrite lua require("packer.load")({'suda.vim'}, { cmd = "SudaWrite", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIUninstall lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIUninstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
