return {
  'mfussenegger/nvim-dap',
  dependencies = { 'rcarriga/nvim-dap-ui', 'nvim-neotest/nvim-nio' },
  config = function()
    local dap = require('dap')
    local dapui = require("dapui")
    dapui.setup()

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath('data') .. "/mason/bin/codelldb.cmd",
        args = { "--port", "${port}" }
      }
    }

    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\build\\bin\\Debug\\', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        -- env = function()
        --   local variables = {}
        --   for k, v in pairs(vim.fn.environ()) do
        --     table.insert(variables, string.format("%s=%s", k, v))
        --   end
        --   return variables
        -- end,
      },
      {
        name = "Attach to process",
        type = 'lldb',
        request = 'attach',
        pid = require('dap.utils').pick_process,
        args = {},
      }
    }
    dap.configurations.c = dap.configurations.cpp

    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { remap = false })
    vim.keymap.set("n", "<F5>", dap.continue, { remap = false })
    vim.keymap.set("n", "<F11>", dap.step_into, { remap = false })
    vim.keymap.set("n", "<S-F11>", dap.step_out, { remap = false })
    vim.keymap.set("n", "<F10", dap.step_over, { remap = false })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    vim.api.nvim_create_user_command('DB', function(opts)
      if (opts.fargs[1] == 'attach') then
        if (#opts.fargs ~= 2) then
          error("Usage: `:DB attach <process_id>`")
        end
        print('attaching to id: ' .. opts.fargs[2])
      end
    end, { nargs = '+' })


  end
}
