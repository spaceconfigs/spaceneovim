local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugins = require("infraestrucuture.plugins.todo")
local snacks = plugins.snacks

M.list = function()
  local message = {
    module = "adapters/todo",
    func = "list",
  }
  logger_use_manage.debug(message)

  snacks.picker.todo_comments()
end

return M
