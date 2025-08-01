-- remap leader key
--vim.keymap.set("n", "<Space>", "", opts)
--vim.g.mapleader = " "
--vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = false }
local fn_expand = vim.fn.expand
local vscode = require("vscode.api")

-- yank to system clipboard
keymap({ "n", "v" }, "<leader>y", "+y", opts)

-- paste from system clipboard
keymap({ "n", "v" }, "<leader>p", "+p", opts)

-- move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("x", "J", ":move >+1<CR>gv-gv", opts)
keymap("x", "K", ":move <-2<CR>gv-gv", opts)

-- paste preserves primal yanked piece
keymap({"x", "v"}, "p", "_dP", opts)

keymap("n", "zb", 'ciw', { noremap = true, silent = false })
keymap("v", "zb", 'c', { noremap = true, silent = false })

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)


--https://github.com/vscode-neovim/vscode-neovim/blob/master/runtime/lua/vscode/api.lua
local function vscode_cmd(command, args)
  return function()
      if args then
          vscode.action(command, args)
          --vim.fn["vscode.send"](command, args)
      else
          vscode.action(command)
          --vim.fn["vscode.send"](command)
      end
  end
end

local function vscode_call(command, args)
  return function()
    vscode.call(command, args)
  end
end

local function vscode_invoke_callback(id, result, is_error)
  return function()
    vscode.invoke_callback(id, result, is_error)
  end
end

-- INFO, WARN, ERROR
local function vscode_notify(msg, level, opts)
  return function()
    vscode.notify(msg, level, opts)
  end
end


-- Visual Mode Keybindings
keymap({ "v" }, "<leader>f", function()
  vscode.with_insert(function()
    -- Get the visually selected text
    -- If selection is whole lines, trim leading/trailing whitespace
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])
    if #lines == 0 then return end
    -- If selection is single line, trim to selected columns
    if #lines == 1 then
      local s = start_pos[3]
      local e = end_pos[3]
      lines[1] = string.sub(lines[1], s, e)
    else
      -- For multi-line, trim first and last line to selected columns
      lines[1] = string.sub(lines[1], start_pos[3])
      lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
    end
    local selected = table.concat(lines, "\n")
    vscode.notify('Searching: ' .. selected)
    vscode.action("workbench.action.findInFiles", {
      args = { query = selected }
    })
  end)
end)

keymap({ "n" }, "<leader>f", function()
  vscode.with_insert(function()
    local word = fn_expand("<cword>")
    vscode_notify('Searching: ' .. word)
    vscode_cmd("workbench.action.findInFiles", {
      args = { query = word }
    })
  end)
end)

keymap({ "v" }, "p", function()
  vscode.with_insert(function()
    vscode.action("editor.action.clipboardPasteAction")
    vim.defer_fn(function()
      local key = vim.api.nvim_replace_termcodes("<esc>", true, true, true)
      vim.api.nvim_feedkeys(key, "n", false)
    end, 100) -- 100ms delay
  end)
end)

keymap({ "n", "x" }, "<leader>r", function()
  vscode.with_insert(function()
    vscode_notify("Refactor")
    vscode.action("editor.action.refactor")
  end)
end)

keymap({ "n", "x" }, "<leader>a", function()
  vscode.with_insert(function()
    vscode.notify("Code Action")
    vscode.action("editor.action.codeAction")
  end)
end)

keymap({ "n", "x" }, "<leader>E", function()
  vscode.with_insert(function()
    vscode.notify("Code Action")
    vscode.action("editor.action.codeAction")
  end)
end)

keymap({ "n", "x" }, "<leader>e", function()
  vscode.with_insert(function()
    vscode.notify("Rename")
    vscode.action("editor.action.rename")
  end)
end)


vim.keymap.set({ "n", "x" }, "<C-u>", function()
    local visibleRanges = require('vscode').eval("return vscode.window.activeTextEditor.visibleRanges")
    local height = visibleRanges[1][2].line - visibleRanges[1][1].line
    for i = 1, height*2/3 do
        vim.api.nvim_feedkeys("k", "n", false)
    end
    -- require('vscode').action("cursorMove", { args = { to= 'viewPortCenter' } })
end)
vim.keymap.set({ "n", "x" }, "<C-d>", function()
    local visibleRanges = require('vscode').eval("return vscode.window.activeTextEditor.visibleRanges")
    local height = visibleRanges[1][2].line - visibleRanges[1][1].line
    for i = 1, height*2/3 do
        vim.api.nvim_feedkeys("j", "n", false)
    end
    -- require('vscode').action("cursorMove", { args = { to= 'viewPortCenter' } })
end)
vim.keymap.set({ "n", "x" }, "<C-f>", function()
    local visibleRanges = require('vscode').eval("return vscode.window.activeTextEditor.visibleRanges")
    local height = visibleRanges[1][2].line - visibleRanges[1][1].line
    for i = 1, height do
        vim.api.nvim_feedkeys("j", "n", false)
    end
end)
vim.keymap.set({ "n", "x" }, "<C-b>", function()
    local visibleRanges = require('vscode').eval("return vscode.window.activeTextEditor.visibleRanges")
    local height = visibleRanges[1][2].line - visibleRanges[1][1].line
    for i = 1, height do
        vim.api.nvim_feedkeys("k", "n", false)
    end
end)