local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.theme")
end

M.list = function()
	local message = {
		module = "use_cases/theme",
		func = "list",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.list()
end

M.load = function()
	local message = {
		module = "use_cases/theme",
		func = "load",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.load()
end

return M
