
exec "source" "~/.vim/shortcutmap.vim"

" }}}

"colorscheme onehalfdark
set background=dark " for the dark version

" Turn off code highlighting
filetype plugin off
syntax off

set guifont=FiraCode\ Nerd\ Font:h14

" cterm      - sets the style
" ctermfg    - set the text color
" ctermbg    - set the highlighting
" DiffAdd    - line was added
" DiffDelete - line was removed
" DiffChange - part of the line was changed (highlights the whole line)
" DiffText   - the exact part of the line that changed

" 新增的行
highlight DiffAdd    ctermbg=235 ctermfg=108 guibg=#262626 guifg=#87af87 cterm=bold gui=NONE
" 删除的行
highlight DiffDelete ctermbg=235 ctermfg=131 guibg=#262626 guifg=#af5f5f cterm=bold gui=reverse
" 差異的行
highlight DiffChange ctermbg=235 ctermfg=103 guibg=#262626 guifg=#8787af cterm=bold gui=NONE
" 差異的文字
highlight DiffText   ctermbg=235 ctermfg=208 guibg=#262626 guifg=#ff8700 cterm=bold gui=NONE

