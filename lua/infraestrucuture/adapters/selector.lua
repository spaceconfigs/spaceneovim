local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
  return require("infraestrucuture.plugins.selector")
end

M.all_selected = function()
  local message = {
    module = "adapters/selector",
    func = "all_selected",
  }
  logger_use_manage.debug(message)
  setup()

  vim.cmd('MCstart')
end

M.quit = function()
  local message = {
    module = "adapters/selector",
    func = "quit",
  }
  logger_use_manage.debug(message)
  setup()

  vim.cmd("MCclear")
end

return M
