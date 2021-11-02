if filereadable(v:lua.get_project_root() . '/phpcs.xml')
    let b:ale_linters = [ 'phpcs' ]
    let b:ale_fixers = [ 'phpcbf' ]
    let b:ale_fix_on_save = v:true
else
    let b:ale_linters = []
    let b:ale_fixers = []
    let b:ale_fix_on_save = v:false
endif
