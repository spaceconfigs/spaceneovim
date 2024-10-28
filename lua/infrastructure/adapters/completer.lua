local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.completer")
local blink_cmp = plugin.blink_cmp

M.complete = function()
  local message = {
    module = "adapters/completer",
    func = "complete",
  }
  logger_use_case.debug(message)

  if blink_cmp.visible() then
    blink_cmp.abort()
  end

  blink_cmp.show()
end

return M
