return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require 'nvim-treesitter.install'.prefer_git = false
    require 'nvim-treesitter.install'.compilers = { "clang", "gcc", "zig" }

    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        --"prisma",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        --"dockerfile",
        "gitignore",
        "c",
        "cpp",
        "python",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })

    -- use bash parser for zsh files
    vim.treesitter.language.register("bash", "zsh")
  end,
}
