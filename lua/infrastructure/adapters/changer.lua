local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugins = require("infrastructure.plugins.changer")
local snacks = plugins.snacks

M.list = function()
  local message = {
    module = "adapters/changer",
    func = "list",
  }
  logger_use_case.debug(message)

  snacks.picker.undo()
end

return M
