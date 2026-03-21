local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.documentation")

M.open = function()
  local message = {
    module = "adapters/documentation",
    func = "open",
  }
  logger_use_manage.debug(message)

  plugin.ui.documentations.show()
end

M.install = function()
  local message = {
    module = "adapters/documentation",
    func = "open",
  }
  logger_use_manage.debug(message)

  plugin.ui.documentations.install()
end

return M
