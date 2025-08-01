if vim.g.vscode then
  print("visualstudiocode loading...")

  require("core")
  require("config.lazy-vscode")
  require("config.vscode-setup")

  require("visualstudiocode")
else
  print("nvim loading...")

  -- Ordinary Neovim
  if vim.loader then
    vim.loader.enable()
  end

  _G.dd = function(...)
    require("util.debug").dump(...)
  end
  vim.print = _G.dd
  -- Running as standalone Neovim
  -- Load full config (plugins, UI, extra settings)
  require("core")
  require("config.lazy")
  require("config.nvim-setup")

  require("custom.plugins.ai")
  require("custom.plugins.completion")
  require("custom.plugins.dap")
  require("custom.plugins.lsp")
  require("custom.plugins.snacks")
end
