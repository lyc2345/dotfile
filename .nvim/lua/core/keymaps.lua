vim.g.mapleader = " "
vim.g.localmapleader = " "

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local keymap = vim.keymap -- for conciseness

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Diagnostic keymaps
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- NeoTree
keymap.set("n", "<leader>e", "<CMD>Neotree toggle<CR>")
keymap.set("n", "<leader>r", "<CMD>Neotree focus<CR>")

-- New Windows
keymap.set("n", "<leader>o", "<CMD>vsplit<CR>")
keymap.set("n", "<leader>p", "<CMD>split<CR>")

-- Window Navigation
-- Use CTRL+<hjkl> to switch between windows
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Resize Windows
keymap.set("n", "<C-Left>", "<C-w><")
keymap.set("n", "<C-Right>", "<C-w>>")
keymap.set("n", "<C-Up>", "<C-w>+")
keymap.set("n", "<C-Down>", "<C-w>-")

-- Save
keymap.set("n", "<leader>w", "<CMD>update<CR>")

-- Quit
keymap.set("n", "<leader>q", "<CMD>q<CR>")

-- Highlight when yanking (copying) text
-- hlsearch
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
