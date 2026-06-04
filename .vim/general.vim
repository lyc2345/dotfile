
" ============================================================
" General (Both Vim & Neovim)
" ============================================================

set history=1000  " Store :cmdline history
set autoread      " Auto reload file when changed in background
set hidden        " Allow background buffers without saving

" Enable filetype plugins
filetype plugin on
filetype plugin indent on

" Clipboard
set clipboard=unnamed

" Mouse
set mouse=a
if !has('nvim') && exists('$TMUX')
  set ttymouse=xterm2
endif

" Auto save
autocmd BufUnload,BufLeave,FocusLost,QuitPre,InsertLeave,TextChanged,CursorHold * silent! wall

" ============================================================
" UI
" ============================================================

set showcmd                     " Show incomplete commands at the bottom
set ruler                       " Always show current position
set backspace=indent,eol,start  " Allow backspace to delete everything
set showmatch                   " Show matching brackets
set mat=2                       " Tenths of a second to blink when matching brackets
syntax enable                   " Syntax highlighting
set encoding=utf-8              " Force UTF-8
set ffs=unix,dos,mac            " Unix as standard file type
set number                      " Show line numbers

" No annoying sound on errors
set noerrorbells
set novisualbell
set vb t_vb=
set tm=500

set foldcolumn=1
set ttimeoutlen=0
set signcolumn=yes
set updatetime=300

" ============================================================
" Files
" ============================================================

set noswapfile
set nowb
set nobackup
set nowritebackup

set exrc    " Enable per-directory .vimrc files
set secure  " Disable unsafe commands in local .vimrc files

" ============================================================
" Indentation
" ============================================================

set smartindent
set smarttab
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

autocmd FileType python setlocal sw=4 ts=4 sts=4

" ============================================================
" Line breaks & scrolling
" ============================================================

set nowrap
set textwidth=0 wrapmargin=0
set nolist
set sidescroll=5
set listchars+=precedes:<,extends:>

set scrolloff=8
set sidescrolloff=15
set sidescroll=1

set splitbelow
set splitright

" ============================================================
" Search
" ============================================================

set ignorecase
set smartcase
set incsearch
set hlsearch
set magic

" ============================================================
" Completion (wildmenu)
" ============================================================

set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~
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

" ============================================================
" Vim only
" ============================================================

if !has('nvim')
  set laststatus=2          " Always show statusline
  set showmode              " Show current mode (Neovim uses lualine)
  set timeoutlen=450        " LazyVim manages this in Neovim (default 300)

  " Fold by indent (Neovim uses treesitter folding)
  set foldmethod=indent
  set foldnestmax=3
  set nofoldenable

  " Don't redraw while executing macros (causes UI bugs in Neovim)
  set lazyredraw
endif
