local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugins = require("infrastructure.plugins.buffer")

local snacks = plugins.snacks

M.list = function()
  local message = {
    module = "adapters/buffer",
    func = "list",
  }
  logger_use_manage.debug(message)

  snacks.picker.buffers()
end

M.delete = function()
  local message = {
    module = "adapters/buffer",
    func = "delete",
  }
  logger_use_manage.debug(message)

  snacks.bufdelete.delete()
end

M.next = function()
  local message = {
    module = "adapters/buffer",
    func = "next",
  }
  logger_use_manage.debug(message)

  vim.cmd("bnext")
end

M.previous = function()
  local message = {
    module = "adapters/buffer",
    func = "previous",
  }
  logger_use_manage.debug(message)

  vim.cmd("bprevious")
end

M.reopen = function()
  local message = {
    module = "adapters/buffer",
    func = "reopen",
  }
  logger_use_manage.debug(message)

  vim.cmd("buffer #")
end

M.close_others = function()
  snacks.bufdelete.other()
end

return M
