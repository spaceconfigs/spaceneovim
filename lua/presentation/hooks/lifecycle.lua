local M = {}

local maps = require("domain.maps")()
local theme_use_case = require("application.use_cases.theme")
local completer_use_case = require("application.use_cases.completer")
local keymapper_use_case = require("application.use_cases.keymapper")
local logger_use_case = require("application.use_cases.logger")
local notification_use_case = require("application.use_cases.notification")
local editor_use_case = require("application.use_cases.editor")

M.afterApplicationInit = function()
  local message = {
    module = "events/lifecycle",
    func = "afterApplicationInit",
  }
  logger_use_case.debug(message)
  theme_use_case.load()
  completer_use_case.setup()
  notification_use_case.setup()
  editor_use_case.setup_jumplist_motions()

  keymapper_use_case.register_all(maps)
end

return M
