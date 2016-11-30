f exists("g:loaded_nerdtree_personal")
    finish
endif
let g:loaded_nerdtree_personal = 1



call NERDTreeAddKeyMap({
       \ 'key': '<C-F12>',
       \ 'callback': 'NERDTreeCtagsHandler',
       \ 'quickhelpText': 'generate ctags on this directory',
       \ 'scope': 'DirNode' })

function! NERDTreeCtagsHandler(dirnode)
    let dirname = a:dirnode.path.str()
    silent let output = system(' ctags -R ' . ' -f  ' . dirname . '\tags ' . '--c++-kinds=+p --c-kinds=+p --fields=+ialS --extra=+q '.dirname)
    if filereadable(dirname . '\tags')
        echom 'tags generated successfully.'
    else 
        echom 'does not exists!!!!!!'
    endif
    call a:dirnode.refresh()
    call NERDTreeRender()
endfunction
