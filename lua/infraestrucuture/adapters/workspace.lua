local M = {}

local logger_use_manage = require("application.use_cases.logger")
local file_usecase = require("application.use_cases.file")
local plugin = require("infraestrucuture.plugins.workspaces")
local workspaces = plugin.workspaces
local snacks = plugin.snacks

M.open = function()
  local message = {
    module = "adapters/workspace",
    func = "open",
  }
  logger_use_manage.debug(message)

  snacks.picker.projects({
    confirm = function(picker, item)
      picker:close()
      vim.fn.chdir(item.file)

      file_usecase.list({ location = "project" })()
    end,
  })
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

return M
