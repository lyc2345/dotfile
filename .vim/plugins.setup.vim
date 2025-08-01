
" Plugin {{{

" File {{{

"let g:supertab_file_path = '~/.vim/supertab.vim'
"if filereadable(expand(g:supertab_file_path))
"  exe ':source' . g:supertab_file_path
"endif

"let g:coc_file_path = '~/.vim/coc.vim'
"if filereadable(expand(g:coc_file_path))
"  exe ':source' . g:coc_file_path
"endif
"
"let g:languages_file_path = '~/.vim/languages.vim'
"if filereadable(expand(g:languages_file_path))
"  exe ':source' . g:languages_file_path
"endif
"
"let g:vam_file_path = '~/.vim/vam.vim'
"if filereadable(expand(g:vam_file_path))
"  exe ':source' . g:vam_file_path
"endif
"
"let g:ale_file_path = '~/.vim/ale.vim'
"if filereadable(expand(g:ale_file_path))
"  exe ':source' . g:ale_file_path
"endif
"
"let g:easymotion_file_path = '~/.vim/vim-easymotion.vim'
"if filereadable(expand(g:easymotion_file_path))
"  exe ':source' . g:easymotion_file_path
"endif

" }}}

" airline {{{
let g:airline_theme='onehalfdark'
let g:lightline= {
    \ 'colorscheme': 'onehalfdark',
    \ }
let g:onedark_color_overrides = {
    \ "background": {"gui": "#2F343F", "cterm": "235", "cterm16": "0" },
    \ "purple": { "gui": "#C678DF", "cterm": "170", "cterm16": "5" }
    \}
let g:onedark_termcolors=256

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" }}}


" ctrlp settings  {{{

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = 'find %s -type f'

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_match_window = 'order:ttb,max:20'

" }}}

" NERDTree {{{

let g:NERDSpaceDelims=1
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" }}}

" gitgutter {{{

let g:gitgutter_enabled = 0

" }}}

" matchmaker {{{
"
let g:matchmaker_enable_startup = 0

" }}}

" vim-session {{{
"
let g:session_directory = getcwd()    " The session directory is always the current directory. This should allow save and restory on a per project basis
let g:session_default_name = ".vim-session"
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_lock_enabled = 0

" }}}

" lsc {{{
"
" for ctag documentation
" lsc-server "https://github.com/natebosch/vim-lsc/wiki/Language-Servers
"  python lsc setup: pip install 'python-language-server[all]'
let g:lsc_server_command = {'python': 'pyls', 'dart': 'dart_language_server' }

" }}}

" syntastic swift {{{
"
let g:syntastic_swift_checkers = ['swift', 'swiftpm', 'swiftlint', 'pylint']
let g:syntastic_swift_swiftlint_use_defaults = 1
" syntastic recommended settings
" When use airline you should NOT follow the recommendation outlined in the syntastic-statusline-flag section
" so comment out this if you're not using airline
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" }}}

" YouCompleteMe {{{

" For M1 chip compling
" https://gist.github.com/bobsomers/f733711b239d32268cb6dcbd87d44568
let g:ycm_clangd_binary_path='/opt/homebrew/opt/llvm/bin/clangd'
" exe command to compile
" cd ~/.vim/plugged/YouCompleteMe/
" arch -arm64 python3 ./install.py --clangd-completer --rust-completer

let g:ycm_enable_inlay_hints                  = 1 " Input hint
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer             = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax        = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments                = 1 " Completion in comments
let g:ycm_complete_in_strings                 = 1 " Completion in string
let g:ycm_min_num_of_chars_for_completion     = 1 " Completion in first input letter
let g:ycm_use_ultisnips_completer             = 0
let g:ycm_semantic_triggers = {
 \ 'objc' : ['re!\@"\.*"\s',
 \ 're!\@\w+\.*\w*\s',
 \ 're!\@\(\w+\.*\w*\)\s',
 \ 're!\@\(\s*',
 \ 're!\@\[.*\]\s',
 \ 're!\@\[\s*',
 \ 're!\@\{.*\}\s',
 \ 're!\@\{\s*',
 \ "re!\@\’.*\’\s",
 \ '#ifdef ',
 \ 're!:\s*',
 \ 're!=\s*',
 \ 're!,\s*', ],
 \ }

let g:ycm_python_binary_path='${HOME}/.pyenv/shims/python'

let g:ycm_language_server = 
  \ [ 
  \   {
  \     'name': 'yaml',
  \     'cmdline': [ '/path/to/yaml/server/yaml-language-server', '--stdio' ],
  \     'filetypes': [ 'yaml' ]
  \   },
  \   {
  \     'name': 'rust',
  \     'cmdline': [ 'ra_lsp_server' ],
  \     'filetypes': [ 'rust' ],
  \     'project_root_files': [ 'Cargo.toml' ]
  \   }
  \ ]

" }}}

" Typescript-vim {{{

let g:typescript_indent_disable = 1
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''

" "}}}

" snipmate {{{

" assuming you want to use snipmate snippet engine
"ActivateAddons vim-snippets snipmate

" }}}

" garbas/vim-snipmate {{{
 
let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'

" }}}

" NerdTree-git-plugin


" RltvNmbr
hi default HL_RltvNmbr_Minus    gui=none,italic ctermfg=red   ctermbg=black guifg=red   guibg=black
hi default HL_RltvNmbr_Positive	gui=none,italic ctermfg=green ctermbg=black guifg=green guibg=black

