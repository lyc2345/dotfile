
" Vim map {{{

" Disable vim built-in complete
inoremap <c-n> <nop>
inoremap <c-p> <nop>

" Visual {{{

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" }}}

" Tmux {{{

nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
nnoremap <silent> <C-h> :TmuxNavigateUp<CR>

" }}}

" Mouse settings {{{

" Enable basic mouse behavior such as resizing buffers.
set mouse=a

if !has('nvim')
  if exists('$TMUX')  " Support resizing in tmux
    set ttymouse=xterm2
  endif
endif

" }}}

" keymap {{{

" leader shortcuts
let mapleader = '\'

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <leader>al :Align

nnoremap <leader>a :Ack<space>

" NERDTree
"nnoremap <leader>c :NERDTreeToggle<cr>
nnoremap <leader>n :NERDTree
nnoremap <leader>f :NERDTreeFind<cr>

" Fzf
" v:oldfiles and open buffers
nnoremap <leader>fh :History<cr>
" Command history
nnoremap <leader>fc :History:<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fu :Colors<cr>

" Coc
nnoremap <silent> <leader>c :<C-u>CocList --normal<CR>

" TagBar
nnoremap <leader>] :TagbarToggle<cr>

" Gitgutter
nnoremap <leader>g  :GitGutterToggle<CR>
nnoremap <leader>gh :GitGutterLineNrHighlightsToggle<CR>
nnoremap <leader>gp :GitGutterPreivewHunk<CR>
nnoremap <leader>r  :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" CtrlP for full path fuzzy file, buffer, mru, tag, ...finder for vim
nnoremap <leader>bb :CtrlPBuffer<cr>
nnoremap <leader>bm :CtrlPMixed<cr>
nnoremap <leader>bs :CtrlPMRU<cr>
nnoremap <leader>bp :CtrlP<cr>
nnoremap <leader>bcc :CtrlPClearCache<cr>:CtrlP<cr>

" }}}


" Buffer {{{
" Close the current buffer
noremap <leader>w :Bclose<cr>:tabclose<cr>gT
noremap <leader>2 :bnext<cr>
noremap <leader>1 :bprevious<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Quickly open a buffer for scribble
map <Leader>q :e ~/buffer<CR>

" Quickly open a markdown buffer for scribble
map <Leader>x :e ~/buffer.md<CR>

" Toggle paste mode on and off
map <Leader>spp :setlocal paste!<CR>

" }}}

" Spell {{{

" Pressing ,ss will toggle and untoggle spell checking
map <Leader>ssp :setlocal spell!<cr>
" Shortcuts using <leader>
map <Leader>sn ]s
map <Leader>sp [s
" add word in .vim/spell/en.utf-8.add
map <Leader>sa zg 
" switch words from spell history
map <Leader>ss z=

" }}}

" Buffer {{{
"
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set spell

" swift
autocmd BufNewFile,BufRead *.swift set filetype=swift

" Jump to the first placeholder by typing `<C-k>`.
autocmd FileType swift imap <buffer> <C-k> <Plug>(autocomplete_swift_jump_to_placeholder)

" }}}


" YouCompleteMe {{{
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nmap <F4> :YcmDiags<CR>


" }}}

" vim command {{{
command! Wq wq
" }}}


" Helper functions {{{

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.ts,*.py,*.wiki,*.sh,*.coffee,*.h,*.m,*.swift :call CleanExtraSpaces()
endif

set pastetoggle=<F2>

" Remove trailing space
" When such a function is called, and it is not defined yet, 
" Vim will search the \"autoload\" directories in 'runtimepath' 
" for a script file called \"filename.vim\". 
" For example \"~/.vim/autoload/filename.vim\".
" See also :help 41.15
" If you want to move these functions into your .vimrc 
" (losing the autoload benefits), 
" you can simply rename them not to contain the # character, 
" (and to start with an upper case letter), 
" but I completely agree with Luc Hermitte that it's not a good idea to do so.
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
     return 'PASTE MODE  '
  endif
  return ''
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'gv'
    call CmdLine("Ack '" . l:pattern . "' " )
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" :Bwipeout[!]
" wipe all deleted/unloaded buffers
command! -bar -bang Bwipeout call misc#bwipeout(<bang>0)

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

function! CmdLine(str)
  call feedkeys(":" . a:str)
endfunction

" Color test: Save this file, then enter ':so %'
" Then enter one of following commands:
"   :VimColorTest    "(for console/terminal Vim)
"   :GvimColorTest   "(for GUI gvim)
function! VimColorTest(outfile, fgend, bgend)
  let result = []
  for fg in range(a:fgend)
    for bg in range(a:bgend)
      let kw = printf('%-7s', printf('c_%d_%d', fg, bg))
      let h = printf('hi %s ctermfg=%d ctermbg=%d', kw, fg, bg)
      let s = printf('syn keyword %s %s', kw, kw)
      call add(result, printf('%-32s | %s', h, s))
    endfor
  endfor
  call writefile(result, a:outfile)
  execute 'edit '.a:outfile
  source %
endfunction
" Increase numbers in next line to see more colors.
command! VimColorTest call VimColorTest('vim-color-test.tmp', 12, 16)

function! GvimColorTest(outfile)
  let result = []
  for red in range(0, 255, 16)
    for green in range(0, 255, 16)
      for blue in range(0, 255, 16)
        let kw = printf('%-13s', printf('c_%d_%d_%d', red, green, blue))
        let fg = printf('#%02x%02x%02x', red, green, blue)
        let bg = '#fafafa'
        let h = printf('hi %s guifg=%s guibg=%s', kw, fg, bg)
        let s = printf('syn keyword %s %s', kw, kw)
        call add(result, printf('%s | %s', h, s))
      endfor
    endfor
  endfor
  call writefile(result, a:outfile)
  execute 'edit '.a:outfile
  source %
endfunction
command! GvimColorTest call GvimColorTest('gvim-color-test.tmp')

" https://www.reddit.com/r/vim/comments/74pw75/how_to_toggle_transparent_background_in_vim/
" https://stackoverflow.com/questions/37712730/set-vim-background-transparent#37720708
let t:is_transparent = 1
function! Toggle_transparent()
  if t:is_transparent == 0
    hi Normal guibg=NONE ctermbg=NONE
    let t:is_transparent = 1
  else
    set background=dark
    let t:is_tranparent = 0
  endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>

function! ToggleBG()
  let s:tbg = &background
  "Inversion
  if s:tbg == "dark"
    set background=light
  else
    set background=dark
  endif
endfunction
noremap <Leader>bg:call ToggleBG()<CR>

" }}}

" }}}


