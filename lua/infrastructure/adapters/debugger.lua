local vim = vim
local M = {}

local logger_use_case = require("application.use_cases.logger")

local debugger = require("infrastructure.plugins.debugger")
local dap = debugger.dap
local dapui = debugger.dapui

-- local file = require("infrastructure.plugins.file")
-- file.telescope.load_extension("dap")
-- local telescope_dap = file.telescope.extensions.dap

vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#993939" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })

vim.fn.sign_define("DapBreakpoint", { text = "󰝥", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "󰮍", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })

dap.listeners.after.event_stopped["dapui_config"] = function()
  vim.api.nvim_command("doautocmd User DapStopped")
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  vim.api.nvim_command("doautocmd User DapTerminated")
end

dap.listeners.before.event_exited["dapui_config"] = function()
  vim.api.nvim_command("doautocmd User DapExited")
end

dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    -- Because of mason we can use this command
    command = 'js-debug-adapter',
    args = { '${port}' },
  }
}

dap.adapters['node-terminal'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    -- Because of mason we can use this command
    command = 'js-debug-adapter',
    args = { '${port}' },
  }
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
  dap.configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach to process',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
    },
    {
      type = 'node-terminal',
      request = 'launch',
      name = 'Launch debug terminal',
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Debug build script',
      -- trace = true, -- include debugger info
      runtimeExecutable = 'yarn',
      runtimeArgs = { 'build' },
      env = {
        NODE_OPTIONS = '--inspect',
      },
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      console = 'integratedTerminal',
      internalConsoleOptions = 'neverOpen',
    },
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Debug Jest tests',
      -- trace = true, -- include debugger info
      runtimeExecutable = 'node',
      runtimeArgs = {
        './node_modules/jest/bin/jest.js',
        '--runInBand',
      },
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      console = 'integratedTerminal',
      internalConsoleOptions = 'neverOpen',
    },
    {
      type = "chrome",
      name = 'Chrome Attach',
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
    },
  }
end

M.clear_breakpoints = function()
  local message = {
    module = "adapters/debugger",
    func = "clear_breakpoints",
  }
  logger_use_case.debug(message)

  dap.clear_breakpoints()
end

M.close = function()
  local message = {
    module = "adapters/debugger",
    func = "close",
  }
  logger_use_case.debug(message)

  dap.terminate()
  dap.close()
end

M.continue = function()
  local message = {
    module = "adapters/debugger",
    func = "continue",
  }
  logger_use_case.debug(message)

  dap.continue()
end

M.list_frames = function()
  local message = {
    module = "adapters/debugger",
    func = "list_frames",
  }
  logger_use_case.debug(message)

  dap.ui.widgets.centered_float(dap.ui.widgets.frames)
end

M.focus_frame = function()
  local message = {
    module = "adapters/debugger",
    func = "focus_frame",
  }
  logger_use_case.debug(message)

  dap.focus_frame()
end

M.go = function(direction)
  local message = {
    module = "adapters/debugger",
    func = "go",
    direction = direction,
  }
  logger_use_case.debug(message)

  local dispatch = { up = dap.up, down = dap.down }
  dispatch[direction]()
end

M.open = function()
  local message = {
    module = "adapters/debugger",
    func = "open",
  }
  logger_use_case.debug(message)

  dapui.open()
end

M.preview = function()
  local message = {
    module = "adapters/debugger",
    func = "preview",
  }
  logger_use_case.debug(message)

  dap.ui.widgets.preview()
end

M.set_exception_breakpoints = function()
  local message = {
    module = "adapters/debugger",
    func = "set_exception_breakpoints",
  }
  logger_use_case.debug(message)

  dap.set_exception_breakpoints()
end

M.step = function(type)
  local message = {
    module = "adapters/debugger",
    func = "step",
    type = type,
  }
  logger_use_case.debug(message)

  dap["step_" .. type]()
end

M.hover = function()
  local message = {
    module = "adapters/debugger",
    func = "hover",
  }
  logger_use_case.debug(message)

  dap.ui.widgets.hover()
end

-- M.list_breakpoints = function()
--   local message = {
--     module = "adapters/debugger",
--     func = "list_breakpoints",
--   }
--   logger_use_case.debug(message)
--
--   telescope_dap.list_breakpoints({ show_line = false })
-- end

M.toggle_breakpoint = function()
  local message = {
    module = "adapters/debugger",
    func = "toggle_breakpoint",
  }
  logger_use_case.debug(message)

  dap.toggle_breakpoint()
end

M.list_variables = function()
  local message = {
    module = "adapters/debugger",
    func = "list_variables",
  }
  logger_use_case.debug(message)

  dap.ui.widgets.centered_float(dap.ui.widgets.scopes)
end

M.set_breakpoint = function(opts)
  local message = {
    module = "adapters/debugger",
    func = "set_breakpoint",
    opts = opts,
  }
  logger_use_case.debug(message)

  dap.set_breakpoint(opts.condition)
end


M.repl_toggle = function()
  local message = {
    module = "adapters/debugger",
    func = "repl_toggle",
  }
  logger_use_case.debug(message)

  dap.repl.toggle()
end

M.run_last = function()
  local message = {
    module = "adapters/debugger",
    func = "run_last",
  }
  logger_use_case.debug(message)

  dap.run_last()
end

M.run_to_cursor = function()
  local message = {
    module = "adapters/debugger",
    func = "run_to_cursor",
  }
  logger_use_case.debug(message)

  dap.run_to_cursor()
end

M.restart_frame = function()
  local message = {
    module = "adapters/debugger",
    func = "restart_frame",
  }
  logger_use_case.debug(message)

  dap.restart_frame()
end

return M
