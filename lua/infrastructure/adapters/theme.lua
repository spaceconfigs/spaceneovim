local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.theme")

M.list = function()
	local message = {
		module = "adapters/theme",
		func = "list",
	}
	logger_use_case.debug(message)

	plugin.themery()
end

M.load = function()
	local message = {
		module = "adapters/theme",
		func = "load",
	}
	logger_use_case.debug(message)
end

return M
