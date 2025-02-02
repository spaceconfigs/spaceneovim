local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.file")
local fzf = plugin.fzf


M.oldfiles = function(opts)
  local message = {
    module = "adapters/file",
    func = "oldfiles",
    opts = opts,
  }
  logger_use_manage.debug(message)


  fzf.oldfiles()
end

M.list = function(opts)
  local message = {
    module = "adapters/file",
    func = "list",
    opts = opts,
  }
  logger_use_manage.debug(message)

  local cwd = opts and opts.path
  fzf.files({ cwd = cwd })
end

return M
