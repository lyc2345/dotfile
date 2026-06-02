
" ============================================================
" General (Both Vim & Neovim)
" ============================================================

" Visual mode * / # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Paste mode toggle
set pastetoggle=<F2>
map <Leader>spp :setlocal paste!<CR>

" Strip trailing whitespace
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>

" Buffer navigation
noremap <leader>2 :bnext<cr>
noremap <leader>1 :bprevious<cr>
map <leader>ba :bufdo bd<cr>

" Quick scratch buffers
map <Leader>q :e ~/buffer<CR>
map <Leader>x :e ~/buffer.md<CR>

" Spell checking
map <Leader>ssp :setlocal spell!<cr>
map <Leader>sn ]s
map <Leader>sp [s
map <Leader>sa zg
map <Leader>ss z=

" Command aliases
command! Wq wq
command! -bar -bang Bwipeout call misc#bwipeout(<bang>0)
command! Bclose call <SID>BufcloseCloseIt()

" Toggle background transparency
let t:is_transparent = 1
function! Toggle_transparent()
  if t:is_transparent == 0
    hi Normal guibg=NONE ctermbg=NONE
    let t:is_transparent = 1
  else
    set background=dark
    let t:is_transparent = 0
  endif
endfunction
nnoremap <C-t> :call Toggle_transparent()<CR>

" Toggle light/dark background
function! ToggleBG()
  let s:tbg = &background
  if s:tbg == "dark"
    set background=light
  else
    set background=dark
  endif
endfunction
noremap <Leader>bg :call ToggleBG()<CR>

" File type detection
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set spell
autocmd BufNewFile,BufRead *.swift set filetype=swift
autocmd FileType swift imap <buffer> <C-k> <Plug>(autocomplete_swift_jump_to_placeholder)

" Clean trailing whitespace on save
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

" ============================================================
" Vim only
" ============================================================

if !has('nvim')
  " leader key (Neovim uses <Space> via LazyVim)
  let mapleader = '\'

  " Disable built-in completion (use plugin instead)
  inoremap <c-n> <nop>
  inoremap <c-p> <nop>

  " Window navigation
  noremap <C-h> <C-w>h
  noremap <C-j> <C-w>j
  noremap <C-k> <C-w>k
  noremap <C-l> <C-w>l

  " Reload vimrc
  nnoremap <leader>r :source ~/.vimrc<CR>:filetype detect<CR>:echo 'vimrc reloaded'<CR>
endif

" ============================================================
" Helper functions
" ============================================================

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
    call CmdLine("Ack '" . l:pattern . "' ")
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/' . l:pattern . '/')
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

function! CmdLine(str)
  call feedkeys(":" . a:str)
endfunction

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
    execute("bdelete! " . l:currentBufNum)
  endif
endfunction
