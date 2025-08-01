--return {
--  "mfussenegger/nvim-dap-python",
--}
--local dap_pathon = require("dap-python")
--dap_pathon.setup("/path/to/venv/bin/python")
--dap_pathon.test_runner = 'pytest'
--
--require('dap-python').setup('/path/to/venv/bin/python')
--table.insert(require('dap').configurations.python, {
--  type = 'python',
--  request = 'launch',
--  name = 'My custom launch configuration',
--  program = '${file}',
--  -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
--})

return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",

    -- Required dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",

    -- Installs the debug adapters for you
    "mason-org/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    "theHamsta/nvim-dap-virtual-text",

    -- Add your own debuggers here
    "mfussenegger/nvim-dap-python",   -- Python debugging support
  },

  -- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
  config = function()
    local python = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
    require("dap-python").setup(python)
  end,

  keys = {
    {
      "<leader>dk",
      function() require("dap").toggle_breakpoint() end,
      desc = "Toggle Breakpoint"
    },
    {
      '<leader>dK',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    {
      "<leader>dc",
      function() require("dap").continue() end,
      desc = "Continue"
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<leader>do',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<leader>dO',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<leader>dt',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
    {
      "<leader>dC",
      function() require("dap").run_to_cursor() end,
      desc = "Run to Cursor"
    },
    {
      "<leader>d.",
      function() require("dap").terminate() end,
      desc = "Terminate"
    },
  },
  config = function()
    -- Load the nvim-dap-ui plugin
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      sidebar = {
        elements = {
          { id = "scopes",      size = 0.25 },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks",      size = 0.25 },
          { id = "watches",     size = 0.25 },
        },
        size = 40,
        position = "left",
      },
      tray = {
        elements = { "repl" },
        size = 10,
        position = "bottom",
      },
      floating = {
        max_height = nil,  -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = nil,   -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be: single, double, rounded, solid, shadow.
      },
    })

    -- Automatically open dap-ui when debugging starts
    dap.listeners.after.event_initialized["dapui_config"] = function()
      require("dapui").open()
    end

    -- Close dap-ui when debugging ends
    dap.listeners.before.event_terminated["dapui_config"] = function()
      require("dapui").close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      require("dapui").close()
    end

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
