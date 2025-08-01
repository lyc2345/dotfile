

" Status line {{{

set laststatus=2 " Always show the statusline
" Format the status line (now using powerlevel9k)
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" }}}


" General {{{

set history=1000 " Store :cmdline history.
set autoread     " Auto reload file when it's changed in the background

" Enable filetype plugins
filetype plugin on
filetype plugin indent on

" share clipboard
set clipboard=unnamed

" keyboard shortcuts
source ~/.vim/keymap.vim

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim


" Using fzf through Homebrew
set rtp+=/usr/local/opt/fzf

" auto save
autocmd BufUnload,BufLeave,FocusLost,QuitPre,InsertLeave,TextChanged,CursorHold * silent! wall

" Use deoplete.
"let g:deoplete#enable_at_startup = 1
"if !exists('g:deoplete#omni#input_patterns')
"    let g:deoplete#omni#input_patterns = {}
"  endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

set showcmd                         " Show incomplete commands at the bottom
set showmode                        " Show current mode at the bottom
set ruler                           " Always show the current position
set backspace=indent,eol,start      " Allow backspace to delete everything
set showmatch                       " Show matching brackets and parentheses when text indicator is over them
set mat=2                           " How many tenths of a second to blink when matching brackets
syntax enable                       " Syntax highlighting
set encoding=utf-8                  " Force UTF-8 as standard encoding
set ffs=unix,dos,mac                " Unix as the standard file type
set number                          " Show line numbers
set guioptions-=r                   " Remove scrollbar for GUI Vim. " No right hand scroll bar

" No annoying sound on errors
set noerrorbells
set novisualbell
" vb=visualbell, t_vb is screen flash
set vb t_vb= " no beep and no flash 
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" Key timeouts
set timeoutlen=450 ttimeoutlen=0

" The current buffer can be put to the background without writing to disk;
" When a background buffer becomes current again, marks and undo-history are remembered.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"  Dir specific vimrc {{{

set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

" }}}

"  Turn Off Swap Files {{{

set noswapfile
set nowb


" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" }}}

" Indentation {{{

"set autoindent        " Automatically indent
set smartindent
set smarttab

" Set softtabs with 4 spaces
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" https://github.com/nathanaelkane/vim-indent-guides
let g:indent_guides_start_level = 1
"let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

" custom indent color
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#333333 ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#444444 ctermbg=4

" python tab setting
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

" Autoformat 4 seconds after the user’s cursor stops moving in normal mode
autocmd FileType objc,objcpp autocmd InsertLeave <buffer> :silent Autoformat
autocmd FileType typescript :set makeprg=tsc

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" }}}

" Line Breaks {{{

" Don't wrap lines physically (auto insertion of newlines)
set nowrap       "Don't wrap lines
set textwidth=0 wrapmargin=0
set nolist  " list disables linebreak
set sidescroll=5
set listchars+=precedes:<,extends:>

" "}}}

" Folds {{{

set foldmethod=indent   " Fold based on indent
set foldnestmax=3       " Deepest fold is 3 levels
set nofoldenable        " Don't fold by default

" }}}

" Completion {{{

set wildmode=list:longest
set wildmenu                      " Enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~       " Stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip

" }}}

" Lazy {{{

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" }}}

" Regular Expression {{{

" For regular expressions turn magic on
set magic

" }}}

" Search {{{

" Ignore case when searching
set ignorecase
" When searching try to be smart about cases 
set smartcase
" Makes search act like search in modern browsers
set incsearch       " Incremental search as you type
set hlsearch        " Highlight search results
hi Search term=reverse ctermbg=11 guibg=darkorange guifg=#000000
hi Visual cterm=none ctermbg=darkgrey ctermfg=cyan 

" }}}

" Scrolling {{{

set scrolloff=20         "Start scrolling when we're 20 lines away from margins
set sidescrolloff=15
set sidescroll=1

" }}}

"}}}


" Splits {{{

set splitbelow
set splitright

" }}}

