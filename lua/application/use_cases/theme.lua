local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.theme")

M.list = function()
	local message = {
		module = "use_cases/theme",
		func = "list",
	}
	logger_use_case.debug(message)

  adapter.list()
end

M.load = function()
	local message = {
		module = "use_cases/theme",
		func = "load",
	}
	logger_use_case.debug(message)

  adapter.load()
end

return M
