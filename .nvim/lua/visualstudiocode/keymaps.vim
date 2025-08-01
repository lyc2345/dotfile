set clipboard=unnamedplus

vnoremap <D-.> <Cmd>lua require('vscode').notify('Starting quick fix') require('vscode').action('editor.action.quickFix')<cr>
"
"" Better Navigation
"nnoremap <silent> <C-j> :call VSCodeNotify("workbench.action.navigateDown")<CR>
"xnoremap <silent> <C-j> :call VSCodeNotify("workbench.action.navigateDown")<CR>
"nnoremap <silent> <C-k> :call VSCodeNotify("workbench.action.navigateUp")<CR>
"xnoremap <silent> <C-k> :call VSCodeNotify("workbench.action.navigateUp")<CR>
"nnoremap <silent> <C-h> :call VSCodeNotify("workbench.action.navigateLeft")<CR>
"xnoremap <silent> <C-h> :call VSCodeNotify("workbench.action.navigateLeft")<CR>
"nnoremap <silent> <C-l> :call VSCodeNotify("workbench.action.navigateRight")<CR>
"xnoremap <silent> <C-l> :call VSCodeNotify("workbench.action.navigateRight")<CR>
"
"nnoremap <C-w>_ :<C-u>call VSCodeNotify("workbench.action.toggleEditorWidths")<CR>
"
"nnoremap <leader>; :call VSCodeNotify("whichkey.show")<CR>
"xnoremap <leader>; :call VSCodeNotify("whichkey.show")<CR>
"
nnoremap <c-n> <Esc>:nohl<CR>


" Which-key
nnoremap <leader>; <Cmd>lua require('vscode').action('whichkey.show')<CR>
nnoremap <leader>. <Cmd>lua require('vscode').action('workbench.action.showCommands')<CR>
nnoremap <leader>> <Cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>
nnoremap <leader># <Cmd>lua require('vscode').action('workbench.action.showAllSymbols')<CR>
nnoremap <leader>@ <Cmd>lua require('vscode').action('workbench.action.gotoSymbol')<CR>

" Bookmarks
"nnoremap bt <Cmd>lua require('vscode').action('bookmarks.toggle')<CR>
"nnoremap bl <Cmd>lua require('vscode').action('bookmarks.list')<CR>
"nnoremap bL <Cmd>lua require('vscode').action('bookmarks.listFromAllFiles')<CR>
"nnoremap bn <Cmd>lua require('vscode').action('bookmarks.jumpToNext')<CR>
"nnoremap bN <Cmd>lua require('vscode').action('bookmarks.jumpToPrevious')<CR>
"nnoremap bs <Cmd>lua require('vscode').action('bookmarks.shrinkSelection')<CR>

" Markers
nnoremap zmN <Cmd>lua require('vscode').action('editor.action.marker.next')<CR>
nnoremap zmM <Cmd>lua require('vscode').action('editor.action.marker.prev')<CR>
nnoremap zmn <Cmd>lua require('vscode').action('editor.action.marker.nextInFiles')<CR>
nnoremap zmm <Cmd>lua require('vscode').action('editor.action.marker.prevInFiles')<CR>


" Editor
nnoremap u <Cmd>lua require('vscode').action('undo')<CR>
nnoremap <c-r> <Cmd>lua require('vscode').action('redo')<CR>
nnoremap K <Cmd>lua require('vscode').action('editor.action.lineBreakInsert')<CR>
nnoremap <leader>e <Cmd>lua require('vscode').action('editor.action.codeAction')<CR>
nnoremap <leader>e <Cmd>lua require('vscode').action('editor.action.rename')<CR>

" Navigation
nnoremap gt <Cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>
nnoremap gT <Cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>
nnoremap <leader>w <Cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>
nnoremap <leader>W <Cmd>lua require('vscode').action('workbench.action.closeEditorsInGroup')<CR>
nnoremap <c-w>w <Cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>
nnoremap <c-w>W <Cmd>lua require('vscode').action('workbench.action.closeEditorsInGroup')<CR>
nnoremap <c-w>l <Cmd>lua require('vscode').action('workbench.action.moveEditorToNextGroup')<CR>
nnoremap <c-w>h <Cmd>lua require('vscode').action('workbench.action.moveEditorToPreviousGroup')<CR>
nnoremap <C-t>l <Cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>
nnoremap <C-t>h <Cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>
nnoremap <Leader>y, <Cmd>lua require('vscode').action('workbench.action.quickOpenNavigateNextInFilePicker')<CR>
nnoremap <Leader>Y, <Cmd>lua require('vscode').action('workbench.action.quickOpenNavigateNextInViewPicker')<CR>
nnoremap <Leader>i, <Cmd>lua require('vscode').action('workbench.action.quickOpenNavigateNextInRecentFilesPicker')<CR>
nnoremap <Leader>I, <Cmd>lua require('vscode').action('workbench.action.quickOpenNavigatePreviousInRecentFilesPicker')<CR>

" Folding
nnoremap z[ <Cmd>lua require('vscode').action('editor.foldRecursively')<CR>
nnoremap z] <Cmd>lua require('vscode').action('editor.unfoldRecursively')<CR>
nnoremap z[[ <Cmd>lua require('vscode').action('editor.foldAll')<CR>
nnoremap z]] <Cmd>lua require('vscode').action('editor.unfoldAll')<CR>

" Search
"keymap("v", "<Leader>f", vscode_cmd("workbench.action.tasks.runTask", ), { noremap = true, silent = false })
"nnoremap <leader>f <Cmd>lua require('vscode').action('workbench.action.tasks.runTask', 'combineSearchAllAndBackToNormalMode')<CR>

"nnoremap <leader>f <Cmd>lua require('vscode').action('editor.action.addSelectionToNextFindMatch')<CR>

"nnoremap <leader>f <Cmd>lua require('vscode').action('editor.action.find')<CR>
"nnoremap <leader>F <Cmd>lua require('vscode').action('editor.action.findInFiles')<CR>
nnoremap gn <Cmd>lua require('vscode').action('gotoNextPreviousMember.nextMember')<CR>
nnoremap gN <Cmd>lua require('vscode').action('gotoNextPreviousMember.previousMember')<CR>

