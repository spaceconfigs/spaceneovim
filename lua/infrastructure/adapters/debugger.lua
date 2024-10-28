local vim = vim
local M = {}

local make_logged = require("application.helpers.make_logged")

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
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })

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
  dap.clear_breakpoints()
end

M.close = function()
  dap.terminate()
  dap.close()
end

M.continue = function()
  dap.continue()
end

M.list_frames = function()
  dap.ui.widgets.centered_float(dap.ui.widgets.frames)
end

M.focus_frame = function()
  dap.focus_frame()
end

M.go = function(direction)
  local dispatch = { up = dap.up, down = dap.down }
  dispatch[direction]()
end

M.open = function()
  dapui.open()
end

M.preview = function()
  dap.ui.widgets.preview()
end

M.set_exception_breakpoints = function()
  dap.set_exception_breakpoints()
end

M.step = function(type)
  dap["step_" .. type]()
end

M.hover = function()
  dap.ui.widgets.hover()
end

-- M.list_breakpoints = function()
--   telescope_dap.list_breakpoints({ show_line = false })
-- end

M.toggle_breakpoint = function()
  dap.toggle_breakpoint()
end

M.list_variables = function()
  dap.ui.widgets.centered_float(dap.ui.widgets.scopes)
end

M.set_breakpoint = function(opts)
  dap.set_breakpoint(opts.condition)
end


M.repl_toggle = function()
  dap.repl.toggle()
end

M.run_last = function()
  dap.run_last()
end

M.run_to_cursor = function()
  dap.run_to_cursor()
end

M.restart_frame = function()
  dap.restart_frame()
end

return make_logged("adapters/debugger", M)
