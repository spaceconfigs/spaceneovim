local M = {}

local logger_use_case = require("application.use_cases.logger")
local debugger_use_case = require("application.use_cases.debugger")

local key_bindings = {
  -- { key = "bb", action = debugger_use_case.toggle_breakpoint },
  -- { key = "bc", action = debugger_use_case.clear_breakpoints },
  -- { key = "bC", action = debugger_use_case.set_breakpoint },
  { key = "c", action = debugger_use_case.continue },
  { key = "i", action = debugger_use_case.step_into },
  { key = "J", action = debugger_use_case.run_to_cursor },
  { key = "o", action = debugger_use_case.step_out },
  { key = "d", action = debugger_use_case.go_down },
  { key = "u", action = debugger_use_case.go_up },
  -- { key = "A", action = debugger_use_case.close },
  { key = "r", action = debugger_use_case.restart_frame },
  { key = "s", action = debugger_use_case.step_over },
  { key = "v", action = debugger_use_case.hover },
  { key = "p", action = "" },
}

M.onActivate = function()
  local message = {
    module = "hooks/debugger",
    func = "onActivate",
  }
  logger_use_case.debug(message)

  local opts = { noremap = true, silent = true }
  for _, binding in ipairs(key_bindings) do
    vim.keymap.set("n", binding.key, binding.action, opts)
  end
end

M.onDeactivate = function()
  local message = {
    module = "hooks/debugger",
    func = "onDeactivate",
  }
  logger_use_case.debug(message)

  for _, binding in ipairs(key_bindings) do
    vim.api.nvim_del_keymap("n", binding.key)
  end
end

return M
