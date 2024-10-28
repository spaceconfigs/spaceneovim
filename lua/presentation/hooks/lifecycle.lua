local M = {}

local maps = require("domain.maps")()
local theme_usecase = require("application.use_cases.theme")
local completer_usecase = require("application.use_cases.completer")
local keymapper_usecase = require("application.use_cases.keymapper")
local logger_usecase = require("application.use_cases.logger")
local notification_usecase = require("application.use_cases.notification")
local editor_usecase = require("application.use_cases.editor")

M.after_application_init = function()
  local message = {
    module = "events/lifecycle",
    func = "after_application_init",
  }
  logger_usecase.debug(message)
  theme_usecase.load()
  completer_usecase.setup()
  notification_usecase.setup()
  editor_usecase.setup_jumplist_motions()

  keymapper_usecase.register_all(maps)
end

return M
