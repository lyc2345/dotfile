
" Declare method to load vim settings {{{

" load the after .vim {{{

function! Load_After_Settings()
    for fpath in split(glob("~/.vim/after/*.vim"), "\n")
        exe "source" fpath
        echo 'loaded' . ' ' . fpath
    endfor
endfunction

" }}}

" load the vimrc.local {{{

function! Load_Local_Settings()
    exe "source" "~/.vim/vimrc.local"
    echo 'loaded vimrc.local'
endfunction

" }}}

" }}}


" Load vim settings {{{


if &diff
  exec "source" "~/.vim/after/plugins.vim"
  exec "source" "~/.vim/difftool.vim"
  finish " stop sourcing here, See :h finish
endif

call Load_After_Settings()
call Load_Local_Settings()

" }}}

