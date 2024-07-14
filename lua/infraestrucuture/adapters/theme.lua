local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	return require("infraestrucuture.plugins.theme")
end

M.list = function()
	local message = {
		module = "adapters/theme",
		func = "list",
	}
	logger_use_manage.debug(message)
  local plugin = setup()

  plugin.themery()
end


M.load = function()
	local message = {
		module = "adapters/theme",
		func = "load",
	}
	logger_use_manage.debug(message)
  local plugin = setup()
end

return M
