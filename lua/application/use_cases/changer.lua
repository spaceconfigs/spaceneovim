local M = {}

local logger_use_case = require("application.use_cases.logger")
M.setup = function()
  return require("infrastructure.adapters.changer")
end

M.list = function()
  local message = {
    module = "use_cases/changer",
    func = "list",
  }
  logger_use_case.debug(message)
  local adapter = M.setup()

  adapter.list()
end

return M
