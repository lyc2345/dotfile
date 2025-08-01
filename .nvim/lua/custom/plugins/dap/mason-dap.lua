return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
    "mason-org/mason.nvim",
  },
  automatic_installation = true,
  ensure_installed = {
    "bash",
    "python",
    "vim",
  },
  -- This line is essential to making automatic installation work
  -- :exploding-brain
  handlers = {
    function(config)
      -- all sources with no handler get passed here

      -- Keep original functionality
      require('mason-nvim-dap').default_setup(config)
    end,
    python = function(config)
        config.adapters = {
          type = "executable",
          command = "/usr/bin/python3",
          args = {
            "-m",
            "debugpy.adapter",
          },
        }
        require('mason-nvim-dap').default_setup(config) -- don't forget this!
    end,
  },
}


--    require('mason-nvim-dap').setup {
--      -- Makes a best effort to setup the various debuggers with
--      -- reasonable debug configurations
--      automatic_installation = true,
--
--      -- You can provide additional configuration to the handlers,
--      -- see mason-nvim-dap README for more information
--      handlers = {},
--
--      -- You'll need to check that you have the required things installed
--      -- online, please don't ask me how to install them :)
--      ensure_installed = {
--        -- Update this to ensure that you have the debuggers for the langs you want
--        "delve",
--        "python"
--      },
--    }
