local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.file")
local snacks = plugin.snacks

M.find = function(opts)
  local message = {
    module = "adapters/commenter",
    func = "toggle",
    opts = opts,
  }
  logger_use_manage.debug(message)

  snacks.picker.commands({ layout = { preset = "ivy_split" } })
end
return M
