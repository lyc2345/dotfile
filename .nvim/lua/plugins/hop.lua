return {
  "phaazon/hop.nvim",
  branch = "v2",
  config = function()
    require("hop").setup({})
    -- place this in one of your configuration file(s)
    local hop = require('hop')
    local directions = require('hop.hint').HintDirection

    vim.keymap.set('', '<leader>ha', function()
      hop.hint_anywhere({})
    end, {remap=true})

    vim.keymap.set('', '<leader>hv', function()
      hop.hint_vertical({})
    end, {remap=true})

    vim.keymap.set('', '<leader>hl', function()
      hop.hint_lines_skip_whitespace()
    end, {remap=true})

    vim.keymap.set('', '<leader>hg', function()
      hop.hint_lines({ directions = directions.AFTER_CURSOR, current_line_only = false })
    end, {remap=true})

    vim.keymap.set('', '<leader>hw', function()
      hop.hint_words({})
    end, {remap=true})

    vim.keymap.set('', '<leader>hf', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
    end, {remap=true})

    vim.keymap.set('', '<leader>hF', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
    end, {remap=true})

    vim.keymap.set('', '<leader>ht', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
    end, {remap=true})

    vim.keymap.set('', '<leader>hT', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
    end, {remap=true})
  end
}