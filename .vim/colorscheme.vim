
" Color Interface {{{

" GUI {{{

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
    if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    
    if (has("termguicolors"))
        " https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
        " set Vim-specific sequences for RGB colors
        " set Vim-specific sequences for RGB colors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    
        " enable true color
        set termguicolors
    endif
endif

" gui settings
if has('gui_running')
    " Set extra options when running in GUI mode
    let g:impact_transbg=1
    set guioptions-=T " No toolbar
    set guioptions-=e " Use built-in tabs
    "set t_Co=256
    set guitablabel=%M\ %t
else
    if &term == 'xterm' || &term == 'screen'
        " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        set t_Co=256
    endif
endif

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" }}}


" scheme {{{

"let g:colors_file_path = '~/.vim/colors.vim'
"if filereadable(expand(g:colors_file_path))
"  exe ':source' . g:colors_file_path
"endif

syntax on
"colorscheme material
colorscheme nord

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
" !!! set background will reset colorscheme, so it should place before colorscheme !!!
set background=dark " for the dark version

" }}}

" Cursor {{{

" Chart of color names >>> https://codeyarns.com/2011/07/29/vim-chart-of-color-names <<<
" http://wiki.csie.ncku.edu.tw/vim/vimrc
set cursorline
"hi CursorLine term=bold cterm=bold guibg=default guifg=snow
"hi Cursor ctermfg=Black ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold

" }}}

" Font {{{
"
set guifont=FiraCode\ Nerd\ Font:h14

" }}}
