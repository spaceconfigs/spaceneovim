local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.theme")

M.list = function()
	local message = {
		module = "adapters/theme",
		func = "list",
	}
	logger_use_manage.debug(message)

	plugin.themery()
end

M.load = function()
	local message = {
		module = "adapters/theme",
		func = "load",
	}
	logger_use_manage.debug(message)
end

return M
