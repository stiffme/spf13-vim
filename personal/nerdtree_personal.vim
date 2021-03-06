if exists('g:loaded_nerdtree_personal')
    finish
endif
let g:loaded_nerdtree_personal = 1

try
    call vimproc#version()
    let g:nerdtree_personal_vimproc = 1
catch //
    let g:nerdtree_personal_vimproc = 0
endtry


call NERDTreeAddKeyMap({
       \ 'key': '<C-F12>',
       \ 'callback': 'NERDTreeCtagsHandler',
       \ 'quickhelpText': 'generate ctags on this directory',
       \ 'scope': 'DirNode' })

function! NERDTreeCtagsHandler(dirnode)
    let dirname = a:dirnode.path.str()
    "silent let output = system(' ctags -R ' . ' -f  ' . dirname . '\tags ' . '--languages=c,c++,java,delos --c++-kinds=+p --c-kinds=+p --fields=+ialS --extra=+q '.dirname)
    let mycmd = 'ctags -R ' . ' -f  ' . dirname . '\tags ' . '--languages=c,c++,java,delos --c++-kinds=+p --c-kinds=+p --fields=+ialS --extra=+q --tag-relative=always '.dirname
    if( has('job') == 1)
        let output_job = job_start(mycmd, {'exit_cb' : 'CtagsExitHandler'} )
        if(job_status(output_job) != 'fail')
            echo 'generating tags in background...'
        else
            echom 'job_start failure:' . job_status(output_job)
        endif
        return
    else
        let output = system(mycmd)
    endif
    if filereadable(dirname . '\tags')
        echom 'tags generated successfully.'
    else 
        echom 'does not exists!!!!!!'
    endif
    call a:dirnode.refresh()
    call NERDTreeRender()
endfunction

function! CtagsExitHandler(job, status)
    if(a:status == 0) 
        echo 'tags generated!'
    else 
        echom 'ctags returns ' . a:status
    endif

endfunction
