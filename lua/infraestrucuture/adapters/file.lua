local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.file")
local snacks_opts = require("infraestrucuture.plugins.lazy.settigs.snacks")
local snacks = plugin.snacks

-- snacks.picker.smart({
    -- layout = { preset = "nitaicharan" },
-- })
M.oldfiles = function(opts)
  local message = {
    module = "adapters/file",
    func = "oldfiles",
    opts = opts,
  }
  logger_use_manage.debug(message)


  snacks.picker.recent({ layout = { preset = "nitaicharan" } })
end

M.list = function(opts)
  local message = {
    module = "adapters/file",
    func = "list",
    opts = opts,
  }
  logger_use_manage.debug(message)

  local cwd = opts and opts.path
  snacks.picker.smart({ cwd = cwd, layout = { preset = "nitaicharan" },
  })
end

return M
