--return {
--  "lukas-reineke/indent-blankline.nvim",
--  event = { "BufReadPre", "BufNewFile" },
--  main = "ibl",
--  opts = {
--    indent = { char = "┊" },
--  },
--}
return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { highlight = { "CursorColumn", "Whitespace" }, char = "" },
    whitespace = {
      highlight = { "CursorColumn", "Whitespace" },
      remove_blankline_trail = false,
    },
    scope = { enabled = false },
  },
}

--config = function()
--  local ibl = require("ibl")
--  local highlight = {
--    "CursorColumn",
--    "Whitespace",
--  }

--  ibl.setup({
--    --indent = { char = "┊" },
--    indent = { highlight = highlight, char = "" },
--    whitespace = {
--      highlight = highlight,
--      remove_blankline_trail = false,
--    },
--    scope = { enabled = false },
--  })

--local highlight = {
--  "CursorColumn",
--  "Whitespace",
--}
--local hooks = require "ibl.hooks"

--ibl.setup({
--  indent = { highlight = highlight, char = "" },
--  whitespace = {
--    highlight = highlight,
--    remove_blankline_trail = false,
--  },
--})
--scope = { enabled = false },

--local highlight = {
--  "RainbowRed",
--  "RainbowYellow",
--  "RainbowBlue",
--  "RainbowOrange",
--  "RainbowGreen",
--  "RainbowViolet",
--  "RainbowCyan",
--}

--local hooks = require "ibl.hooks"
---- create the highlight groups in the highlight setup hook, so they are reset
---- every time the colorscheme changes
--hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
--  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
--  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
--  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
--  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
--  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
--  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
--end)

--ibl.setup { indent = { highlight = highlight } }
--end
--}
