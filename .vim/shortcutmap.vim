
" Easy way to back to normal mode.
inoremap jj <Esc>

" Append symbol ';' or ',' at the end of line.
nnoremap z; A;<Esc>
inoremap z; <Esc>A;<Esc>
nnoremap z: A:<Esc>
inoremap z: <Esc>A:<Esc>
nnoremap z, A,<Esc>
inoremap z, <Esc>A,<Esc>
nnoremap z. A.<Esc>
inoremap z. <Esc>A.<Esc>
nnoremap z' A'<Esc>
inoremap z' <Esc>A'<Esc>
nnoremap z" A"<Esc>
inoremap z" <Esc>A"<Esc>
inoremap z) <Esc>A)<Esc>
inoremap z] <Esc>A]<Esc>
inoremap z} <Esc>A}<Esc>
nnoremap z\ <Esc>A<SPACE>\<Esc>
inoremap z\ <Esc>A<SPACE>\<Esc>

"nnoremap <C-o> a<CR><Esc>k$

nnoremap ;, <Esc>f,la<CR><Esc>k$<Esc>
nnoremap ;. <Esc>f.la<CR><Esc>k$<Esc>
nnoremap ,, <Esc>F,la<CR><Esc>k$<Esc>
nnoremap ,. <Esc>F.la<CR><Esc>k$<Esc>
nnoremap zz) <Esc>f)i<CR><Esc>k$<Esc>
nnoremap zz] <Esc>f]i<CR><Esc>k$<Esc>
nnoremap zz} <Esc>f}i<CR><Esc>k$<Esc>
nnoremap zz( <Esc>F(a<CR><Esc>k$<Esc>
nnoremap zz[ <Esc>F[a<CR><Esc>k$<Esc>
nnoremap zz{ <Esc>F{a<CR><Esc>k$<Esc>

" Goto beginning or end of line when in insert or normal mode.
nnoremap zh ^
nnoremap zl $
inoremap zzh <Esc>^i
inoremap zzl <Esc>A
vnoremap zh ^
vnoremap zl $

" <CR> is Return or Enter
"nnoremap za<CR> a<CR><Esc>
"nnoremap zi<CR> i<CR><Esc>
"nnoremap zs<CR> s<CR><Esc>

" Delete to the begin or end of line in [normal] or [visual]
nnoremap zdh <Esc>v^d
inoremap zdh l<Esc>v^c
nnoremap zdl <Esc>C
inoremap zdl l<Esc>C

imap zt <Esc>\0<SPACE>p

" Deleting words at cursor position and switch to [insert]
nnoremap zb ciw
vnoremap zb <Esc>ciw
" Delete words at cursor position and switch back to [normal]
" also delete the symbol right next to the words
"nnoremap zx elvbx<Esc>
"vnoremap zx <Esc>elvbx<Esc>
"nnoremap zz bhvex<Esc>
"vnoremap zz <Esc>bhvex<Esc>

" f<character> jump to next <character>
" F<character> jump to previous <character>
" ; repeat f jump forward
" , repeat f jump backward

" 後接著輸入符號, 複製符號中的文字
" copy words between the next input symbol
nnoremap zs yi
" copy word at cursor position
nnoremap zc yiw
" copy word at cursor position
nnoremap zcc yiw
" delete words between the next input symbol
nnoremap zi ci
" delete words between the next input symbol, symbol included
nnoremap za ca
" highlight select words between the next input symbol, e.g. (a, b, c, d): z) => 選取 a, b, c, d
nnoremap zv vi
" highlight select word at cursor position
nnoremap zvv viw
" replace current words with clipboard
nnoremap zr "_diw"+P

" yy or Y is for copying whole line

" delete surrounding quote
" h move left
" P paste before cursor
" l move right
" 2x right delete 2 unit at cursor
nnoremap zd' di'hPl2x
nnoremap zd" di"hPl2x
nnoremap zd} di}hPl2x
nnoremap zd] di]hPl2x
nnoremap zd> di>hPl2x
nnoremap zd) di)hPl2x
" delete surrounding symbols
vnoremap zdd dhPl2x

" add words-surrounding symbols by input symbol
" ysiw is \"your surround inner word", from `:help ys`
nmap ze ysiw
nnoremap <Leader>y ysiw

" visual add words-surrounding symbols
" 1. visual mode highlight selected 2. press S 3. press symbol you want to add

" Trigger easymotion (<leader><leader>)

" <Leader>f{char} to move to {char}
map  <Leader><Leader>f <Plug>(easymotion-bd-f)
nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
map <Leader><Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader><Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader><Leader>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader><Leader>w <Plug>(easymotion-bd-w)
nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

" Clean last search result highlight with ctrl + n
nnoremap <C-n> :nohl<CR>
" Press Enter to clean last search result highlight
nnoremap <CR> :nohl<CR>
vnoremap <Leader><Leader> <Esc>

nmap wwww zwq
nnoremap zwq :wq<CR>

nmap qqqq zqq
nnoremap zqq :q!<CR>

" These z + bymbol now is mapped to zv
" 選取下列符號中所有內容, e.g. (a, b, c, d): z) => 選取 a, b, c, d
" highlight select words between symbols
"nnoremap z) vi)
"nnoremap z} vi}
"nnoremap z> vi>
"nnoremap c> ci>
"nnoremap z" vi"
"nnoremap z' vi'
"nnoremap z] vi]
"nnoremap z[ vi[

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

"nnoremap <Tab> >>
"nnoremap <S-Tab> <<

"} jumps entire paragraphs downwards
"{ similarly but upwards
"CTRL-D let’s you move down half a page
"CTRL-U let’s you move up half a page

"ds' to delete the surrounding '
"cs'" to change the surrounding ' for "

"\\w trigger EasyMotion following first of word
"\\e trigger EasyMotion following end of word
"\\f trigger EasyMotion following find letter

"daw to delete a word (plus trailing whitespace)
"ciw to change inner word
"das to delete a sentence (dis delete inner sentence)
"da" to delete something in double quotes including the quotes
"ci" to change something inside double quotes
"dap to delete a paragraph
"dab da( or da) to delete a block surrounded by (
"daB da{ or da} to delete a block surrounded by {
"dat to delete an HTML tag
"cit to change the contents of an HTML tag

"gd to jump to definition of whatever is under your cursor
"gf to jump to a file in an import

"di" to delete word surrounded by "
"di} to delete word surrounded by }

"Surround.vim is all about \"surroundings": parentheses, brackets, quotes, XML tags, and more. The plugin provides mappings to easily delete, change and add such surroundings in pairs.
"It's easiest to explain with examples. Press `cs"'` inside
"
"    \"Hello world!"
"
"to change it to
"
"    'Hello world!'
"
"Now press `cs'<q>` to change it to
"
"    <q>Hello world!</q>
"
"To go full circle, press `cst"` to get
"
"    \"Hello world!"
"
"To remove the delimiters entirely, press `ds"`.
"
"    Hello world!
"
"Now with the cursor on \"Hello", press `ysiw]` (`iw` is a text object).
"
"    [Hello] world!
"
"Let's make that braces and add some space (use `}` instead of `{` for no space): `cs]{`
"
"    { Hello } world!
"
"Now wrap the entire line in parentheses with `yssb` or `yss)`.
"
"    ({ Hello } world!)
"
"Revert to the original text: `ds{ds)`
"
"    Hello world!
"
"Emphasize hello: `ysiw<em>`
"
"    <em>Hello</em> world!
"
"Finally, let's try out visual mode. Press a capital V (for linewise visual mode) followed by `S<p class="important">`.
"
"    <p class="important">
"      <em>Hello</em> world!
"    </p>
"

