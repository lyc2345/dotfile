return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", config = true },
    "mason-org/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    --{ "folke/neodev.nvim", opts = {}, }, -- no longer needed if using Lazy vim

    -- Useful status updates for LSP.
    {
      "j-hui/fidget.nvim",
      opts = {
        notification = {
          window = {
            winblend = 0, -- Background color opacity in the notification window
          },
        },
      },
    },
  },
  config = function()
    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufnr = ev.buf

        -- set keybinds
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { buffer = bufnr, desc = "Show LSP references" }) -- show definition, references

        keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" }) -- go to declaration

        keymap.set("n", "gD", "<cmd>Telescope lsp_definitions<CR>", { buffer = bufnr, desc = "Show LSP definitions" }) -- show lsp definitions

        keymap.set(
          "n",
          "gi",
          "<cmd>Telescope lsp_implementations<CR>",
          { buffer = bufnr, desc = "Show LSP implementations" }
        ) -- show lsp implementations

        keymap.set(
          "n",
          "gt",
          "<cmd>Telescope lsp_type_definitions<CR>",
          { buffer = bufnr, desc = "Show LSP type definitions" }
        ) -- show lsp type definitions

        keymap.set(
          { "n", "v" },
          "<leader>ca",
          vim.lsp.buf.code_action,
          { buffer = bufnr, desc = "See available code actions" }
        ) -- see available code actions, in visual mode will apply to selection

        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Smart rename" }) -- smart rename

        keymap.set(
          "n",
          "<leader>D",
          "<cmd>Telescope diagnostics bufnr=0<CR>",
          { buffer = bufnr, desc = "Show buffer diagnostics" }
        ) -- show  diagnostics for file

        keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show line diagnostics" }) -- show diagnostics for line

        keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Go to previous diagnostic" }) -- jump to previous diagnostic in buffer

        keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Go to next diagnostic" }) -- jump to next diagnostic in buffer

        keymap.set(
          "n",
          "K",
          vim.lsp.buf.hover,
          { buffer = bufnr, desc = "Show documentation for what is under cursor" }
        ) -- show documentation for what is under cursor

        keymap.set("n", "<leader>rs", ":LspRestart<CR>", { buffer = bufnr, desc = "Restart LSP" }) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.config("svelte", {
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            -- Here use ctx.match instead of ctx.file
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end,
    })

    vim.lsp.config("graphql", {
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    vim.lsp.config("emmet_ls", {
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    vim.lsp.config("eslint", {
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
  end,
}
