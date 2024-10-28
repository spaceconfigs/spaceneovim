local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.file")
local snacks = plugin.snacks

M.find = function(opts)
  local message = {
    module = "adapters/commenter",
    func = "toggle",
    opts = opts,
  }
  logger_use_case.debug(message)

  snacks.picker.commands()
end
return M
