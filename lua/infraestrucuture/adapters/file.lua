local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.file")
local snacks = plugin.snacks

M.oldfiles = function(opts)
  local message = {
    module = "adapters/file",
    func = "oldfiles",
    opts = opts,
  }
  logger_use_manage.debug(message)


  snacks.picker.recent({ layout = { preset = "ivy_split" } })
end

M.list = function(opts)
  local message = {
    module = "adapters/file",
    func = "list",
    opts = opts,
  }
  logger_use_manage.debug(message)

  local cwd = opts and opts.path
  snacks.picker.smart({ cwd = cwd, layout = { preset = "ivy_split" } })
end

return M
