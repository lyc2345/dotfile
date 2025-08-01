require("visualstudiocode.keymaps")
require "visualstudiocode.plugins.easymotion"
require "visualstudiocode.plugins.vscode-multi-cursor"

require('vscode').action("neovim-ui-indicator.cursorCenter")

vim.cmd("source " .. vim.fn.stdpath('config') .. "/lua/visualstudiocode/keymaps.vim")
--vim.cmd("source $HOME/.config/nvim/lua/visualstudiocode/keymaps.vim")

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
        local mode = vim.api.nvim_get_mode().mode
        if mode == "i" then
            require('vscode').action("neovim-ui-indicator.insert")
        elseif mode == "v" then
            require('vscode').action("neovim-ui-indicator.visual")
        elseif mode == "n" then
            require('vscode').action("neovim-ui-indicator.normal")
        end
    end,
})