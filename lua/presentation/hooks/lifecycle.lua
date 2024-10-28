local M = {}

local maps = require("domain.maps")()
local theme_usecase = require("application.usecases.theme")
-- local completer_usecase = require("application.usecases.completer")
local keymapper_usecase = require("application.usecases.keymapper")
local logger_usecase = require("application.usecases.logger")
local notification_usecase = require("application.usecases.notification")
local editor_usecase = require("application.usecases.editor")

M.after_application_init = function()
  local message = {
    module = "events/lifecycle",
    func = "after_application_init",
  }
  logger_usecase.debug(message)
  theme_usecase.load()
  -- completer_usecase.setup()
  notification_usecase.setup()
  editor_usecase.setup_jumplist_motions()

  keymapper_usecase.register_all(maps)
end

return M
