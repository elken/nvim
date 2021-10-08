if filereadable(expand('%:p:h') . '/phpcs.xml')
    let b:ale_linters = [ 'phpcs' ]
    let b:ale_fixers = [ 'phpcbf' ]
else
    let b:ale_linters = []
    let b:ale_fixers = []
    let b:ale_fix_on_save = 0
endif
