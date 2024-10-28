local M = {}

local logger_usecase = require("application.use_cases.logger")
local debugger_usecase = require("application.use_cases.debugger")
local keymapper_usecase = require("application.use_cases.keymapper")

local key_bindings = {
  -- { key = "bb", action = debugger_usecase.toggle_breakpoint },
  -- { key = "bc", action = debugger_usecase.clear_breakpoints },
  -- { key = "bC", action = debugger_usecase.set_breakpoint },
  { key = "c", action = debugger_usecase.continue },
  { key = "i", action = debugger_usecase.step_into },
  { key = "J", action = debugger_usecase.run_to_cursor },
  { key = "o", action = debugger_usecase.step_out },
  { key = "d", action = debugger_usecase.go_down },
  { key = "u", action = debugger_usecase.go_up },
  -- { key = "A", action = debugger_usecase.close },
  { key = "r", action = debugger_usecase.restart_frame },
  { key = "s", action = debugger_usecase.step_over },
  { key = "v", action = debugger_usecase.hover },
  { key = "p", action = "" },
}

M.on_debugger_activate = function()
  logger_usecase.debug({
    module = "hooks/debugger",
    func = "on_debugger_activate",
  })

  for _, binding in ipairs(key_bindings) do
    keymapper_usecase.set({
      mode = "n",
      key = binding.key,
      action = binding.action,
      noremap = true,
      silent = true,
    })
  end
end

M.on_debugger_deactivate = function()
  logger_usecase.debug({
    module = "hooks/debugger",
    func = "on_debugger_deactivate",
  })

  for _, binding in ipairs(key_bindings) do
    keymapper_usecase.unset({ mode = "n", key = binding.key })
  end
end

return M
