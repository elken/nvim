if filereadable(v:lua.get_project_root() . '/.stylua.toml')
    let b:ale_fixers = [ 'stylua' ]
    let b:ale_linters = [ 'stylua' ]
    let b:ale_fix_on_save = v:true
else
    let b:ale_fixers = []
    let b:ale_linters = []
    let b:ale_fix_on_save = v:false
endif
