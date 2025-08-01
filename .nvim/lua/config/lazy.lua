--local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--if not vim.loop.fs_stat(lazypath) then
--  vim.fn.system({
--    "git",
--    "clone",
--    "--filter=blob:none",
--    "https://github.com/folke/lazy.nvim.git",
--    "--branch=stable", -- latest stable release
--    lazypath,
--  })
--end
--vim.opt.rtp:prepend(lazypath)
--
--require("lazy").setup(
--  {
--    { import = "plugins" },
--    { import = "plugins.lsp" } ,
--  },
--  {
--    checker = {
--      enabled = true,
--      notify = false,
--    },
--    change_detection = {
--      notify = false,
--    },
--  },
--)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  spec = {
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        news = {
          lazyvim = true,
          neovim = true,
        },
      },
    },
    -- import your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyodark", "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
  chenge_detection = { notify = false },
})

-- -- Ordinary neovim
-- --
-- -- Bootstrap lazy.nvim
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--   local lazyrepo = "https://github.com/folke/lazy.nvim.git"
--   local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
--   if vim.v.shell_error ~= 0 then
--     vim.api.nvim_echo({
--       { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
--       { out, "WarningMsg" },
--       { "\nPress any key to exit..." },
--     }, true, {})
--     vim.fn.getchar()
--     os.exit(1)
--   end
-- end
-- vim.opt.rtp:prepend(lazypath)

-- -- Make sure to setup `mapleader` and `maplocalleader` before
-- -- loading lazy.nvim so that mappings are correct.
-- -- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- -- Setup lazy.nvim
-- require("lazy").setup({
--   spec = {
--   	-- add LazyVim and import its plugins
--   	--
--   	{
--   		"LazyVim/LazyVim",
--   		import = "lazyvim.plugins",
--   		opts = {
--   			colorscheme = "tokyodark",
--   			news = {
--   				lazyvim = true,
--   				neovim = true,
--   			},
--   		},
--   	},

--   --	-- import any extras modules here
--   --	--{ import = "lazyvim.plugins.extras.linting.eslint" },
--   --	--{ import = "lazyvim.plugins.extras.formatting.prettier" },
--   --	--{ import = "lazyvim.plugins.extras.lang.typescript" },
--   --	--{ import = "lazyvim.plugins.extras.lang.json" },
--   --	--{ import = "lazyvim.plugins.extras.lang.markdown" },
--   --	--{ import = "lazyvim.plugins.extras.lang.rust" },
--   --	--{ import = "lazyvim.plugins.extras.lang.tailwind" },
--   --	-- { import = "lazyvim.plugins.extras.dap.core" },
--   --	-- { import = "lazyvim.plugins.extras.vscode" },
--   --	--{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
--   --	-- { import = "lazyvim.plugins.extras.test.core" },
--   --	-- { import = "lazyvim.plugins.extras.coding.yanky" },
--   --	-- { import = "lazyvim.plugins.extras.editor.mini-files" },
--   --	-- { import = "lazyvim.plugins.extras.util.project" },
--   --	-- import your plugins
--   	{ import = "plugins" },
--   	{ import = "plugins.lsp" },
--   --},
--   --defaults = {
--   --	-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
--   --	-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
--   --	lazy = false,
--   --	-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
--   --	-- have outdated releases, which may break your Neovim install.
--   --	version = false, -- always use the latest git commit
--   --	-- version = "*", -- try installing the latest stable version for plugins that support semver
--   --},
--   -- Configure any other settings here. See the documentation for more details.
--   -- colorscheme that will be used when installing plugins.
--   --install = { colorscheme = {} },
--   -- automatically check for plugin updates
--   checker = {
--     enabled = true, -- check for plugin updates periodically
--     notify = false, -- notify on update
--   }, -- automatically check for plugin updates
--   change_detection = {
--     notify = true,
--   },
--   performance = {
--     rtp = {
--     -- disable some rtp plugins
--     disabled_plugins = {
--       "gzip",
--       -- "matchit",
--       -- "matchparen",
--       -- "netrwPlugin",
--       "tarPlugin",
--       "tohtml",
--       "tutor",
--       "zipPlugin",
--     },
--   },
-- },
-- })
