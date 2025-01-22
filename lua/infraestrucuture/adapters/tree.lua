local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugins = require("infraestrucuture.plugins.tree")
local nvim_tree = plugins.nvim_tree
local yazi = plugins.yazi
local nvim_tree = plugins.nvim_tree

M.open = function()
  local message = {
    module = "adapters/todo",
    func = "open",
  }
  logger_use_manage.debug(message)

  nvim_tree.open()
end

M.close = function()
  local message = {
    module = "adapters/todo",
    func = "close",
  }
  logger_use_manage.debug(message)

  nvim_tree.close()
end

M.toggle = function(opts)
  local message = {
    module = "adapters/todo",
    func = "toggle",
    opts = opts,
  }
  logger_use_manage.debug(message)

  -- nvim_tree.toggle()
  yazi.toggle()
end

return M
