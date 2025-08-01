set nocompatible

" configure Pathogen
if empty(glob('~/.vim/autoload/pathogen.vim'))
  silent !curl -fLo ~/.vim/autoload/pathogen.vim --create-dirs
    \ https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Pathogen plugin
" using pathogen
execute pathogen#infect()

" configure Vundle
if empty(glob('~/.vim/bundle/Vundle.vim'))
  "silent !curl -fLo ~/.vim/bundle/Vundle.vim --create-dirs
  ""  \ https://raw.githubusercontent.com/VundleVim/Vundle.vim
  "autocmd VimEnter * PluginInstall --sync | source $MYVIMRC
  silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  autocmd VimEnter * PluginInstall
endif

filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" install Vundle bundles
Plugin 'VundleVim/Vundle.vim'
"Plugin 'ervandew/supertab'
"Plugin 'metalelf0/supertab' "supertab fork
Plugin 'airblade/vim-gitgutter'
Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'kchmck/vim-coffee-script'
Plugin 'ctrlpvim/ctrlp.vim' " Full path fuzzy file, buffer, mru, tag, ... finder for vim
Plugin 'leafgarland/typescript-vim'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim' " search tool

" snippet
"Plugin 'SirVer/ultisnips'
" SnipMate friend
"Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

"Plugin 'honza/vim-snippets'

"Plugin 'chrisbra/Colorizer'

" https://github.com/Valloric/YouCompleteMe#mac-os-x
" Compiling YCM with semantic support for C-family languages:
"   cd ~/.vim/bundle/YouCompleteMe
"   ./install.py --clang-completer
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
"Plugin 'vim-ruby/vim-ruby'
"Plugin 'vim-scripts/greplace.vim'
"Plugin 'vim-scripts/matchit.zip'
Plugin 'rakr/vim-one'

Plugin 'vim-scripts/Align'

Plugin 'syngan/vim-vimlint'

" move cursor rapidly
Plugin 'easymotion/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-easymotion.vim'

" vim airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Plugin 'Shougo/deoplete.nvim' " switch to vim-plug
" auto complete for language
"Plugin 'mitsuse/autocomplete-swift'
"Plugin 'nsf/gocode', {'rtp': 'vim/'}

" Lint language
Plugin 'dense-analysis/ale'

" Plugin for markdown format
"Plugin 'plasticboy/vim-markdown'

Plugin 'godlygeek/tabular' " Aligning text https://github.com/godlygeek/tabular
Plugin 'joshdick/onedark.vim'
Plugin 'sonph/onehalf', { 'rtp': 'vim' }

" swift syntax Highlight
" Plugin 'file:///Users/stan/.swiftenv/shims/swift', {'rtp': 'utils/vim/','name': 'Swift-Syntax'}

" File manager
Plugin 'vifm/vifm.vim'
Plugin 'RltvNmbr.vim'

"Plugin 'tpope/vim-bundler'
"Plugin 'tpope/vim-commentary'
"Plugin 'tpope/vim-cucumber'
"Plugin 'tpope/vim-dispatch'
"Plugin 'tpope/vim-endwise'
"Plugin 'tpope/vim-fugitive'
"Plugin 'tpope/vim-pastie'
"Plugin 'tpope/vim-ragtag'
"Plugin 'tpope/vim-rails'
"Plugin 'tpope/vim-repeat'
"Plugin 'tpope/vim-unimpaired'

call vundle#end()

" Configure vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/github/copilot.vim.git'

" Shougo switch from vundle to vim-plug
"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
Plug 'yuezk/vim-js'
Plug 'nordtheme/vim'

" Plug outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.config/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'tpope/vim-dispatch'   " Asynchronous build
"Plug 'eraserhd/vim-ios'    " .h <-> .m switching and project build
"Plug 'gilgigilgil/anderson.vim'
Plug 'Raimondi/delimitMate'    " Automatically insert closing brackets
"
Plug 'tpope/vim-surround' " Add, remove, and change surrounding characters in pairs
Plug 'justinmk/vim-sneak'
Plug 'phaazon/hop.nvim'
Plug 'ggandor/leap.nvim'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

"Plug 'qstrahl/vim-matchmaker'   " Highlight the term under the cursor
"Plug 'Chiel92/vim-autoformat'  " Auto-format code using existing formatters
"Plug 'xolox/vim-session'    " Save and restore vim state
"Plug 'xolox/vim-misc'
" Use release branch (recommended)
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Code completion
"Plug 'luochen1990/rainbow'

" Dart
Plug 'dart-lang/dart-vim-plugin'
" vim-lsc is a language server client helps you find definitions
" lsc-server "https://github.com/natebosch/vim-lsc/wiki/Language-Servers
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

Plug 'gko/vim-coloresque'

" Plug 'junegunn/vim-easy-align'
"Plug 'keith/swift.vim'

" organize notes and ideas and quickly create links between them,
" manage todo-lists, write a diary
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
" markdown preview
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'sheerun/vim-polyglot'

call plug#end()


