local M = {}

local maps = require("domain.maps")
local theme_use_case = require("application.use_cases.theme")
local completer_use_case = require("application.use_cases.completer")
local keymapper_use_case = require("application.use_cases.keymapper")
local logger_use_case = require("application.use_cases.logger")
local notification_use_case = require("application.use_cases.notification")

M.onModuleInit = function()
  local message = {
    module = "events/lifecycle",
    func = "onModuleInit",
  }
  logger_use_case.debug(message)
  theme_use_case.load()
  completer_use_case.setup()
  notification_use_case.setup()

  keymapper_use_case.register_all(maps)
end

return M
