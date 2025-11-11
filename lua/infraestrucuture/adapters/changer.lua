local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugins = require("infraestrucuture.plugins.changer")
local snacks = plugins.snacks

M.list = function()
  local message = {
    module = "adapters/changer",
    func = "list",
  }
  logger_use_manage.debug(message)

  snacks.picker.undo()
end

return M
