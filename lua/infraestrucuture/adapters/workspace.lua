local M = {}

local logger_use_manage = require("application.use_cases.logger")
local file_usecase = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.workspaces")
local workspaces = plugin.workspaces
local snacks = plugin.snacks

snacks.picker.projects({ layout = { preset = "nitaicharan" } })

M.open = function()
  local message = {
    module = "adapters/workspace",
    func = "open",
  }
  logger_use_manage.debug(message)

  -- snacks.picker.projects()
  workspaces.workspaces()
end

M.add = function(opts)
  local message = {
    module = "adapters/workspace",
    func = "add",
    opts = opts,
  }
  logger_use_manage.debug(message)

  workspaces.add(opts.path)
end

M.files = function(opts)
  local message = {
    module = "adapters/workspace",
    func = "files",
    opts = opts,
  }
  logger_use_manage.debug(message)

  file_usecase.list({ location = "profile" })()
end

return M
