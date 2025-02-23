local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.documentation")

M.open = function()
  local message = {
    module = "adapters/documentation",
    func = "open",
  }
  logger_use_manage.debug(message)

  vim.cmd("DevdocsOpen")
end

return M
