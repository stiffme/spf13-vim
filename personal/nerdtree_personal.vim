call NERDTreeAddKeyMap({
       \ 'key': '<C-F12>',
       \ 'callback': 'NERDTreeCtagsHandler',
       \ 'quickhelpText': 'generate ctags on this directory',
       \ 'scope': 'DirNode' })

function! NERDTreeCtagsHandler(dirnode)
    "let dirname = a:dirnode.getDir()
    echo items(a:dirnode)
    "execute '!ctags -R --c++-kinds=+p -c-kinds=+p --fields=+ialS --extra=+q '.dirname ' -f  ' . dirname . '/tags'. <CR> 
endfunction


