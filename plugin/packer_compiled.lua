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
    path = "/Users/elken/.local/share/nvim/site/pack/packer/opt/DAPInstall.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\nï\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\3\20separator_style\nslant\27always_show_bufferline\1\16diagnostics\rnvim_lsp\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/bufferline.nvim"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/diffview.nvim"
  },
  firenvim = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  ["format.nvim"] = {
    commands = { "Format", "FormatWrite" },
    config = { "\27LJ\2\nÃ\1\0\0\6\0\14\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0004\3\3\0005\4\4\0005\5\3\0=\5\5\4>\4\1\3=\3\a\0024\3\3\0005\4\t\0005\5\b\0=\5\5\4>\4\1\3=\3\n\0024\3\3\0005\4\f\0005\5\v\0=\5\5\4>\4\1\3=\3\r\2B\0\2\1K\0\1\0\bphp\1\0\0\1\2\0\0\vphpcbf\blua\1\0\0\1\2\0\0\15lua-format\6*\1\0\0\bcmd\1\0\0\1\2\0\0\24sed -i 's/[ \t]*$//'\nsetup\vformat\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/opt/format.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nÃ\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\20buftype_exclude\1\3\0\0\rterminal\vnofile\21filetype_exclude\1\0\1\19use_treesitter\2\1\22\0\0\rstartify\14dashboard\16dotooagenda\blog\rfugitive\14gitcommit\vpacker\fvimwiki\rmarkdown\tjson\btxt\nvista\thelp\ftodoist\rNvimTree\rpeekaboo\bgit\20TelescopePrompt\rundotree\24flutterToolsOutline\5\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lightspeed.nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/lightspeed.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nZ\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\ntheme\tnord\nsetup\flualine\frequire\0" },
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
    config = { "\27LJ\2\nq\0\0\3\0\6\0\r6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\4\0'\2\5\0B\0\2\1K\0\1\0\21colorscheme nord\bcmd\17nord_borders\18nord_contrast\6g\bvim\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nord.nvim"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-bqf"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire°\2\0\1\t\1\v\1*6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\21Ä-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\t\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\n\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\1¿\5!<Plug>luasnip-expand-or-jump\23expand_or_jumpable\6n\n<C-n>\27nvim_replace_termcodes\bapi\rfeedkeys\15pumvisible\afn\bvim\2ñ\2\0\1\t\1\v\1+6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\22Ä-\1\0\0009\1\b\1)\3ˇˇB\1\2\2\15\0\1\0X\2\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\t\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\n\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\1¿\5\28<Plug>luasnip-jump-prev\rjumpable\6n\n<C-p>\27nvim_replace_termcodes\bapi\rfeedkeys\15pumvisible\afn\bvim\2‹\1\0\2\5\0\n\0\0176\2\1\0'\4\2\0B\2\2\0029\2\3\0029\2\4\0029\3\0\0018\2\3\2'\3\5\0009\4\0\1&\2\4\2=\2\0\0015\2\a\0009\3\b\0009\3\t\0038\2\3\2=\2\6\1L\1\2\0\tname\vsource\1\0\5\vbuffer\r[Buffer]\rnvim_lua\n[Lua]\rnvim_lsp\n[LSP]\18latex_symbols\f[Latex]\fluasnip\14[LuaSnip]\tmenu\6 \fdefault\fpresets\flspkind\frequire\tkind‘\4\1\0\n\0)\0F6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0026\1\0\0'\3\4\0B\1\2\0029\2\5\0005\4\b\0004\5\3\0005\6\6\0>\6\1\0055\6\a\0>\6\2\5=\5\t\0045\5\v\0003\6\n\0=\6\f\5=\5\r\0045\5\16\0009\6\14\0009\6\15\6B\6\1\2=\6\17\0059\6\14\0009\6\18\6B\6\1\2=\6\19\0059\6\14\0009\6\20\6)\b¸ˇB\6\2\2=\6\21\0059\6\14\0009\6\20\6)\b\4\0B\6\2\2=\6\22\0059\6\14\0009\6\23\6B\6\1\2=\6\24\0059\6\14\0009\6\25\6B\6\1\2=\6\26\0059\6\14\0009\6\27\0065\b\30\0009\t\28\0009\t\29\t=\t\31\bB\6\2\2=\6 \0053\6!\0=\6\"\0053\6#\0=\6$\5=\5\14\0045\5&\0003\6%\0=\6'\5=\5(\4B\2\2\0012\0\0ÄK\0\1\0\15formatting\vformat\1\0\0\0\f<S-Tab>\0\n<Tab>\0\t<CR>\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\n<C-g>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-d>\16scroll_docs\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\nsetup\fluasnip\bcmp\tinit\flspkind\frequire\0" },
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
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    config = { "\27LJ\2\nA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1¿\24nvim_buf_set_keymap\bapi\bvimA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1¿\24nvim_buf_set_option\bapi\bvimê\15\1\2\v\0001\0Ü\0013\2\0\0003\3\1\0\18\4\3\0'\6\2\0'\a\3\0B\4\3\0015\4\4\0\18\5\2\0'\a\5\0'\b\6\0'\t\a\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\b\0'\t\t\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\n\0'\t\v\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\f\0'\t\r\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\14\0'\t\15\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\16\0'\t\17\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\18\0'\t\19\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\20\0'\t\21\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\22\0'\t\23\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\24\0'\t\25\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\26\0'\t\27\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\28\0'\t\29\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\30\0'\t\31\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b \0'\t!\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\"\0'\t#\0\18\n\4\0B\5\5\0016\5$\0009\5%\5'\a&\0B\5\2\0019\5'\0009\5(\5\15\0\5\0X\6\aÄ\18\5\2\0'\a\5\0'\b)\0'\t*\0\18\n\4\0B\5\5\1X\5\nÄ9\5'\0009\5+\5\15\0\5\0X\6\6Ä\18\5\2\0'\a\5\0'\b)\0'\t,\0\18\n\4\0B\5\5\0019\5'\0009\5-\5\15\0\5\0X\6\6Ä6\5$\0009\5.\0059\5/\5'\a0\0+\b\1\0B\5\3\0012\0\0ÄK\0\1\0¡\2                    augroup lsp_document_highlight\n                    autocmd! * <buffer>\n                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n                    augroup END\n                        \14nvim_exec\bapi\23document_highlight0<cmd>lua vim.lsp.buf.range_formatting()<CR>\30document_range_formatting*<cmd>lua vim.lsp.buf.formatting()<CR>\r<space>f\24document_formatting\26resolved_capabilities= command! Format execute 'lua vim.lsp.buf.formatting()' \bcmd\bvim2<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>\r<space>q0<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\a]d0<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\a[d<<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>\r<space>e*<cmd>lua vim.lsp.buf.references()<CR>\agr&<cmd>lua vim.lsp.buf.rename()<CR>\14<space>rn/<cmd>lua vim.lsp.buf.type_definition()<CR>\r<space>DJ<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>\14<space>wl7<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>\14<space>wr4<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>\14<space>wa.<cmd>lua vim.lsp.buf.signature_help()<CR>\n<C-k>.<cmd>lua vim.lsp.buf.implementation()<CR>\agi%<Cmd>lua vim.lsp.buf.hover()<CR>\6K*<Cmd>lua vim.lsp.buf.definition()<CR>\agd+<Cmd>lua vim.lsp.buf.declaration()<CR>\agD\6n\1\0\2\fnoremap\2\vsilent\2\27v:lua.vim.lsp.omnifunc\romnifunc\0\0Û\1\0\0\n\3\v\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0B\0\1\0026\1\4\0\18\3\0\0B\1\2\4H\4\16Ä5\6\5\0-\a\0\0=\a\6\6-\a\1\0=\a\a\6\a\5\b\0X\a\2Ä-\a\2\0=\a\t\0066\a\0\0'\t\n\0B\a\2\0028\a\5\a9\a\2\a\18\t\6\0B\a\2\1F\4\3\3R\4ÓK\0\1\0\1Ä\0¿\2¿\14lspconfig\rsettings\blua\14on_attach\17capabilities\1\0\0\npairs\22installed_servers\nsetup\15lspinstall\frequire5\0\0\3\1\3\0\a-\0\0\0B\0\1\0016\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\3¿\fbufdo e\bcmd\bvim‹\3\1\0\t\0!\00023\0\0\0006\1\1\0009\1\2\0019\1\3\0019\1\4\1B\1\1\0026\2\5\0'\4\6\0B\2\2\0029\2\a\2\18\4\1\0B\2\2\2\18\1\2\0005\2\t\0005\3\b\0=\3\n\0025\3\16\0005\4\v\0006\5\1\0009\5\f\0056\a\r\0009\a\14\a'\b\15\0B\5\3\2=\5\14\4=\4\17\0035\4\19\0005\5\18\0=\5\20\4=\4\21\0035\4\25\0006\5\1\0009\5\22\0059\5\23\5'\a\24\0+\b\2\0B\5\3\2=\5\26\4=\4\27\3=\3\28\0023\3\29\0\18\4\3\0B\4\1\0016\4\5\0'\6\30\0B\4\2\0023\5 \0=\5\31\0042\0\0ÄK\0\1\0\0\22post_install_hook\15lspinstall\0\bLua\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\16diagnostics\fglobals\1\0\0\1\2\0\0\bvim\fruntime\1\0\0\6;\tpath\fpackage\nsplit\1\0\1\fversion\vLuaJIT\14filetypes\1\0\0\1\2\0\0\blua\24update_capabilities\17cmp_nvim_lsp\frequire\29make_client_capabilities\rprotocol\blsp\bvim\0\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-toggleterm.lua"] = {
    config = { "\27LJ\2\nÂ\1\0\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\3=\3\6\0025\3\a\0005\4\b\0=\4\t\3=\3\n\2B\0\2\1K\0\1\0\15float_opts\15highlights\1\0\2\vborder\vNormal\15background\vNormal\1\0\2\vborder\vdouble\rwinblend\3\0\nshell\6o\bvim\1\0\3\14direction\nfloat\17hide_numbers\2\tsize\3Z\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÔ\16\0\0\a\0?\0N6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\15\0\0\0X\1\5Ä6\0\4\0'\2\5\0B\0\2\0025\1\a\0=\1\6\0006\0\4\0'\2\b\0B\0\2\0029\0\t\0B\0\1\0025\1\14\0005\2\v\0005\3\f\0=\3\r\2=\2\15\1=\1\n\0005\1\19\0005\2\17\0005\3\18\0=\3\r\2=\2\15\1=\1\16\0006\1\4\0'\3\20\0B\1\2\0029\1\21\0015\3\22\0005\4\23\0=\4\24\0035\4\25\0005\5\26\0=\5\27\4=\4\28\0035\4\29\0=\4\30\0035\4\31\0005\5 \0=\5\27\4=\4!\0035\4\"\0=\4#\0035\4&\0005\5$\0005\6%\0=\6\27\5=\5'\0045\5(\0005\6)\0=\6*\0055\6+\0=\6,\0055\6-\0=\6.\0055\6/\0=\0060\5=\0051\4=\0042\0035\0043\0005\0054\0=\0055\4=\0046\0035\0047\0005\0058\0=\0059\4=\4:\0035\4;\0=\4<\0035\4=\0=\4>\3B\1\2\1K\0\1\0\26context_commentstring\1\0\1\venable\2\14tree_docs\1\0\1\venable\2\frainbow\vcolors\1\b\0\0\f#bf616a\f#d08770\f#ebcb8b\f#a3be8c\f#88c0d0\f#5e81ac\f#b48ead\1\0\3\venable\2\18extended_mode\2\19max_file_lines\3Ë\a\15playground\16keybindings\1\0\n\14show_help\6?\14goto_node\t<cr>\vupdate\6R\21unfocus_language\6F\19focus_language\6f\28toggle_language_display\6I\27toggle_anonymous_nodes\6a\30toggle_injected_languages\6t\21toggle_hl_groups\6i\24toggle_query_editor\6o\1\0\3\15updatetime\3\25\venable\2\20persist_queries\1\16textobjects\tmove\22goto_previous_end\1\0\5\tgpiC\16@call.inner\bgpC\16@call.outer\bgpP\21@parameter.inner\tgpiF\20@function.inner\bgpF\20@function.outer\24goto_previous_start\1\0\5\bgpp\21@parameter.inner\tgpif\20@function.inner\bgpf\20@function.outer\tgpic\16@call.inner\bgpc\16@call.outer\18goto_next_end\1\0\5\bgnF\20@function.outer\tgniC\16@call.inner\bgnC\16@call.outer\bgnP\21@parameter.inner\tgniF\20@function.inner\20goto_next_start\1\0\5\tgnic\16@call.inner\bgnp\21@parameter.inner\bgnc\16@call.outer\tgnif\20@function.inner\bgnf\20@function.outer\1\0\2\14set_jumps\2\venable\2\vselect\1\0\0\1\0\f\balp\16@loop.outer\bisc\21@scopename.inner\aiB\17@block.inner\bast\21@statement.outer\6p\21@parameter.inner\bacd\23@conditional.outer\bilp\16@loop.inner\bacm\19@comment.outer\aif\20@function.inner\bicd\23@conditional.inner\aaB\17@block.outer\aaf\20@function.outer\1\0\1\venable\2\14autopairs\1\0\1\venable\2\17textsubjects\1\0\1\6,\23textsubjects-smart\1\0\1\venable\2\vindent\1\0\1\venable\2\26incremental_selection\fkeymaps\1\0\4\21node_incremental\bgnn\21node_decremental\bgnp\19init_selection\bgnn\22scope_incremental\bgns\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\1\0\1\rfiletype\rmarkdown\1\3\0\0\17src/parser.c\19src/scanner.cc\1\0\1\burl5https://github.com/ikatyang/tree-sitter-markdown\rmarkdown\17install_info\1\0\1\rfiletype\fhaskell\nfiles\1\3\0\0\17src/parser.c\19src/scanner.cc\1\0\1\burl7https://github.com/tree-sitter/tree-sitter-haskell\fhaskell\23get_parser_configs\28nvim-treesitter.parsers\1\2\0\0\vgcc-11\14compilers\28nvim-treesitter.install\frequire\nmacos\bhas\afn\bvim\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
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
    config = { "\27LJ\2\nx\0\0\3\0\6\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0'\2\5\0B\0\2\1K\0\1\0\rprojects\19load_extension\14telescope\nsetup\17project_nvim\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/project.nvim"
  },
  ["suda.vim"] = {
    commands = { "SudaWrite", "SudaRead" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/opt/suda.vim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\n∑\1\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2Q<cmd>lua require(\"telescope.builtin\").builtin({include_extensions=true})<CR>\21<leader><leader>\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
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
  ["which-key.nvim"] = {
    config = { "\27LJ\2\nn\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\fplugins\1\0\0\rspelling\1\0\0\1\0\1\fenabled\2\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/Users/elken/.local/share/nvim/site/pack/packer/start/which-key.nvim"
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

-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\2\nx\0\0\3\0\6\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0'\2\5\0B\0\2\1K\0\1\0\rprojects\19load_extension\14telescope\nsetup\17project_nvim\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)
-- Config for: nord.nvim
time([[Config for nord.nvim]], true)
try_loadstring("\27LJ\2\nq\0\0\3\0\6\0\r6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\4\0'\2\5\0B\0\2\1K\0\1\0\21colorscheme nord\bcmd\17nord_borders\18nord_contrast\6g\bvim\0", "config", "nord.nvim")
time([[Config for nord.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nÃ\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\20buftype_exclude\1\3\0\0\rterminal\vnofile\21filetype_exclude\1\0\1\19use_treesitter\2\1\22\0\0\rstartify\14dashboard\16dotooagenda\blog\rfugitive\14gitcommit\vpacker\fvimwiki\rmarkdown\tjson\btxt\nvista\thelp\ftodoist\rNvimTree\rpeekaboo\bgit\20TelescopePrompt\rundotree\24flutterToolsOutline\5\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\nï\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\3\20separator_style\nslant\27always_show_bufferline\1\16diagnostics\rnvim_lsp\nsetup\15bufferline\frequire\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: nvim-toggleterm.lua
time([[Config for nvim-toggleterm.lua]], true)
try_loadstring("\27LJ\2\nÂ\1\0\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\3=\3\6\0025\3\a\0005\4\b\0=\4\t\3=\3\n\2B\0\2\1K\0\1\0\15float_opts\15highlights\1\0\2\vborder\vNormal\15background\vNormal\1\0\2\vborder\vdouble\rwinblend\3\0\nshell\6o\bvim\1\0\3\14direction\nfloat\17hide_numbers\2\tsize\3Z\nsetup\15toggleterm\frequire\0", "config", "nvim-toggleterm.lua")
time([[Config for nvim-toggleterm.lua]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire°\2\0\1\t\1\v\1*6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\21Ä-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\t\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\n\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\1¿\5!<Plug>luasnip-expand-or-jump\23expand_or_jumpable\6n\n<C-n>\27nvim_replace_termcodes\bapi\rfeedkeys\15pumvisible\afn\bvim\2ñ\2\0\1\t\1\v\1+6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\22Ä-\1\0\0009\1\b\1)\3ˇˇB\1\2\2\15\0\1\0X\2\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\t\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\n\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\1¿\5\28<Plug>luasnip-jump-prev\rjumpable\6n\n<C-p>\27nvim_replace_termcodes\bapi\rfeedkeys\15pumvisible\afn\bvim\2‹\1\0\2\5\0\n\0\0176\2\1\0'\4\2\0B\2\2\0029\2\3\0029\2\4\0029\3\0\0018\2\3\2'\3\5\0009\4\0\1&\2\4\2=\2\0\0015\2\a\0009\3\b\0009\3\t\0038\2\3\2=\2\6\1L\1\2\0\tname\vsource\1\0\5\vbuffer\r[Buffer]\rnvim_lua\n[Lua]\rnvim_lsp\n[LSP]\18latex_symbols\f[Latex]\fluasnip\14[LuaSnip]\tmenu\6 \fdefault\fpresets\flspkind\frequire\tkind‘\4\1\0\n\0)\0F6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0026\1\0\0'\3\4\0B\1\2\0029\2\5\0005\4\b\0004\5\3\0005\6\6\0>\6\1\0055\6\a\0>\6\2\5=\5\t\0045\5\v\0003\6\n\0=\6\f\5=\5\r\0045\5\16\0009\6\14\0009\6\15\6B\6\1\2=\6\17\0059\6\14\0009\6\18\6B\6\1\2=\6\19\0059\6\14\0009\6\20\6)\b¸ˇB\6\2\2=\6\21\0059\6\14\0009\6\20\6)\b\4\0B\6\2\2=\6\22\0059\6\14\0009\6\23\6B\6\1\2=\6\24\0059\6\14\0009\6\25\6B\6\1\2=\6\26\0059\6\14\0009\6\27\0065\b\30\0009\t\28\0009\t\29\t=\t\31\bB\6\2\2=\6 \0053\6!\0=\6\"\0053\6#\0=\6$\5=\5\14\0045\5&\0003\6%\0=\6'\5=\5(\4B\2\2\0012\0\0ÄK\0\1\0\15formatting\vformat\1\0\0\0\f<S-Tab>\0\n<Tab>\0\t<CR>\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\n<C-g>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-d>\16scroll_docs\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\nsetup\fluasnip\bcmp\tinit\flspkind\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: orgmode.nvim
time([[Config for orgmode.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\forgmode\frequire\0", "config", "orgmode.nvim")
time([[Config for orgmode.nvim]], false)
-- Config for: nvim-lspinstall
time([[Config for nvim-lspinstall]], true)
try_loadstring("\27LJ\2\nA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1¿\24nvim_buf_set_keymap\bapi\bvimA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1¿\24nvim_buf_set_option\bapi\bvimê\15\1\2\v\0001\0Ü\0013\2\0\0003\3\1\0\18\4\3\0'\6\2\0'\a\3\0B\4\3\0015\4\4\0\18\5\2\0'\a\5\0'\b\6\0'\t\a\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\b\0'\t\t\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\n\0'\t\v\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\f\0'\t\r\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\14\0'\t\15\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\16\0'\t\17\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\18\0'\t\19\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\20\0'\t\21\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\22\0'\t\23\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\24\0'\t\25\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\26\0'\t\27\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\28\0'\t\29\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\30\0'\t\31\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b \0'\t!\0\18\n\4\0B\5\5\1\18\5\2\0'\a\5\0'\b\"\0'\t#\0\18\n\4\0B\5\5\0016\5$\0009\5%\5'\a&\0B\5\2\0019\5'\0009\5(\5\15\0\5\0X\6\aÄ\18\5\2\0'\a\5\0'\b)\0'\t*\0\18\n\4\0B\5\5\1X\5\nÄ9\5'\0009\5+\5\15\0\5\0X\6\6Ä\18\5\2\0'\a\5\0'\b)\0'\t,\0\18\n\4\0B\5\5\0019\5'\0009\5-\5\15\0\5\0X\6\6Ä6\5$\0009\5.\0059\5/\5'\a0\0+\b\1\0B\5\3\0012\0\0ÄK\0\1\0¡\2                    augroup lsp_document_highlight\n                    autocmd! * <buffer>\n                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n                    augroup END\n                        \14nvim_exec\bapi\23document_highlight0<cmd>lua vim.lsp.buf.range_formatting()<CR>\30document_range_formatting*<cmd>lua vim.lsp.buf.formatting()<CR>\r<space>f\24document_formatting\26resolved_capabilities= command! Format execute 'lua vim.lsp.buf.formatting()' \bcmd\bvim2<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>\r<space>q0<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\a]d0<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\a[d<<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>\r<space>e*<cmd>lua vim.lsp.buf.references()<CR>\agr&<cmd>lua vim.lsp.buf.rename()<CR>\14<space>rn/<cmd>lua vim.lsp.buf.type_definition()<CR>\r<space>DJ<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>\14<space>wl7<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>\14<space>wr4<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>\14<space>wa.<cmd>lua vim.lsp.buf.signature_help()<CR>\n<C-k>.<cmd>lua vim.lsp.buf.implementation()<CR>\agi%<Cmd>lua vim.lsp.buf.hover()<CR>\6K*<Cmd>lua vim.lsp.buf.definition()<CR>\agd+<Cmd>lua vim.lsp.buf.declaration()<CR>\agD\6n\1\0\2\fnoremap\2\vsilent\2\27v:lua.vim.lsp.omnifunc\romnifunc\0\0Û\1\0\0\n\3\v\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0B\0\1\0026\1\4\0\18\3\0\0B\1\2\4H\4\16Ä5\6\5\0-\a\0\0=\a\6\6-\a\1\0=\a\a\6\a\5\b\0X\a\2Ä-\a\2\0=\a\t\0066\a\0\0'\t\n\0B\a\2\0028\a\5\a9\a\2\a\18\t\6\0B\a\2\1F\4\3\3R\4ÓK\0\1\0\1Ä\0¿\2¿\14lspconfig\rsettings\blua\14on_attach\17capabilities\1\0\0\npairs\22installed_servers\nsetup\15lspinstall\frequire5\0\0\3\1\3\0\a-\0\0\0B\0\1\0016\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\3¿\fbufdo e\bcmd\bvim‹\3\1\0\t\0!\00023\0\0\0006\1\1\0009\1\2\0019\1\3\0019\1\4\1B\1\1\0026\2\5\0'\4\6\0B\2\2\0029\2\a\2\18\4\1\0B\2\2\2\18\1\2\0005\2\t\0005\3\b\0=\3\n\0025\3\16\0005\4\v\0006\5\1\0009\5\f\0056\a\r\0009\a\14\a'\b\15\0B\5\3\2=\5\14\4=\4\17\0035\4\19\0005\5\18\0=\5\20\4=\4\21\0035\4\25\0006\5\1\0009\5\22\0059\5\23\5'\a\24\0+\b\2\0B\5\3\2=\5\26\4=\4\27\3=\3\28\0023\3\29\0\18\4\3\0B\4\1\0016\4\5\0'\6\30\0B\4\2\0023\5 \0=\5\31\0042\0\0ÄK\0\1\0\0\22post_install_hook\15lspinstall\0\bLua\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\16diagnostics\fglobals\1\0\0\1\2\0\0\bvim\fruntime\1\0\0\6;\tpath\fpackage\nsplit\1\0\1\fversion\vLuaJIT\14filetypes\1\0\0\1\2\0\0\blua\24update_capabilities\17cmp_nvim_lsp\frequire\29make_client_capabilities\rprotocol\blsp\bvim\0\0", "config", "nvim-lspinstall")
time([[Config for nvim-lspinstall]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nZ\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\ntheme\tnord\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÔ\16\0\0\a\0?\0N6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\15\0\0\0X\1\5Ä6\0\4\0'\2\5\0B\0\2\0025\1\a\0=\1\6\0006\0\4\0'\2\b\0B\0\2\0029\0\t\0B\0\1\0025\1\14\0005\2\v\0005\3\f\0=\3\r\2=\2\15\1=\1\n\0005\1\19\0005\2\17\0005\3\18\0=\3\r\2=\2\15\1=\1\16\0006\1\4\0'\3\20\0B\1\2\0029\1\21\0015\3\22\0005\4\23\0=\4\24\0035\4\25\0005\5\26\0=\5\27\4=\4\28\0035\4\29\0=\4\30\0035\4\31\0005\5 \0=\5\27\4=\4!\0035\4\"\0=\4#\0035\4&\0005\5$\0005\6%\0=\6\27\5=\5'\0045\5(\0005\6)\0=\6*\0055\6+\0=\6,\0055\6-\0=\6.\0055\6/\0=\0060\5=\0051\4=\0042\0035\0043\0005\0054\0=\0055\4=\0046\0035\0047\0005\0058\0=\0059\4=\4:\0035\4;\0=\4<\0035\4=\0=\4>\3B\1\2\1K\0\1\0\26context_commentstring\1\0\1\venable\2\14tree_docs\1\0\1\venable\2\frainbow\vcolors\1\b\0\0\f#bf616a\f#d08770\f#ebcb8b\f#a3be8c\f#88c0d0\f#5e81ac\f#b48ead\1\0\3\venable\2\18extended_mode\2\19max_file_lines\3Ë\a\15playground\16keybindings\1\0\n\14show_help\6?\14goto_node\t<cr>\vupdate\6R\21unfocus_language\6F\19focus_language\6f\28toggle_language_display\6I\27toggle_anonymous_nodes\6a\30toggle_injected_languages\6t\21toggle_hl_groups\6i\24toggle_query_editor\6o\1\0\3\15updatetime\3\25\venable\2\20persist_queries\1\16textobjects\tmove\22goto_previous_end\1\0\5\tgpiC\16@call.inner\bgpC\16@call.outer\bgpP\21@parameter.inner\tgpiF\20@function.inner\bgpF\20@function.outer\24goto_previous_start\1\0\5\bgpp\21@parameter.inner\tgpif\20@function.inner\bgpf\20@function.outer\tgpic\16@call.inner\bgpc\16@call.outer\18goto_next_end\1\0\5\bgnF\20@function.outer\tgniC\16@call.inner\bgnC\16@call.outer\bgnP\21@parameter.inner\tgniF\20@function.inner\20goto_next_start\1\0\5\tgnic\16@call.inner\bgnp\21@parameter.inner\bgnc\16@call.outer\tgnif\20@function.inner\bgnf\20@function.outer\1\0\2\14set_jumps\2\venable\2\vselect\1\0\0\1\0\f\balp\16@loop.outer\bisc\21@scopename.inner\aiB\17@block.inner\bast\21@statement.outer\6p\21@parameter.inner\bacd\23@conditional.outer\bilp\16@loop.inner\bacm\19@comment.outer\aif\20@function.inner\bicd\23@conditional.inner\aaB\17@block.outer\aaf\20@function.outer\1\0\1\venable\2\14autopairs\1\0\1\venable\2\17textsubjects\1\0\1\6,\23textsubjects-smart\1\0\1\venable\2\vindent\1\0\1\venable\2\26incremental_selection\fkeymaps\1\0\4\21node_incremental\bgnn\21node_decremental\bgnp\19init_selection\bgnn\22scope_incremental\bgns\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\1\0\1\rfiletype\rmarkdown\1\3\0\0\17src/parser.c\19src/scanner.cc\1\0\1\burl5https://github.com/ikatyang/tree-sitter-markdown\rmarkdown\17install_info\1\0\1\rfiletype\fhaskell\nfiles\1\3\0\0\17src/parser.c\19src/scanner.cc\1\0\1\burl7https://github.com/tree-sitter/tree-sitter-haskell\fhaskell\23get_parser_configs\28nvim-treesitter.parsers\1\2\0\0\vgcc-11\14compilers\28nvim-treesitter.install\frequire\nmacos\bhas\afn\bvim\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: neogit
time([[Config for neogit]], true)
try_loadstring("\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0", "config", "neogit")
time([[Config for neogit]], false)
-- Config for: markdown-preview.nvim
time([[Config for markdown-preview.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\ffirefox\17mkdp_browser\6g\bvim\0", "config", "markdown-preview.nvim")
time([[Config for markdown-preview.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\nn\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\fplugins\1\0\0\rspelling\1\0\0\1\0\1\fenabled\2\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SudaWrite lua require("packer.load")({'suda.vim'}, { cmd = "SudaWrite", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SudaRead lua require("packer.load")({'suda.vim'}, { cmd = "SudaRead", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIInstall lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIInstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIUninstall lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIUninstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIList lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIList", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSPlaygroundToggle lua require("packer.load")({'playground'}, { cmd = "TSPlaygroundToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Octo lua require("packer.load")({'octo.nvim'}, { cmd = "Octo", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Format lua require("packer.load")({'format.nvim'}, { cmd = "Format", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file FormatWrite lua require("packer.load")({'format.nvim'}, { cmd = "FormatWrite", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
