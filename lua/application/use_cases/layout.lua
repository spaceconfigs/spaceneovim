local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.layout")

M.list = function()
	local message = {
		module = "use_cases/layout",
		func = "list",
	}
	logger_use_case.debug(message)

	adapter.list()
end

M.reload = function()
	local message = {
		module = "use_cases/layout",
		func = "reload",
	}
	logger_use_case.debug(message)

	adapter.reload()
end

M.save = function()
	local message = {
		module = "use_cases/layout",
		func = "save",
	}
	logger_use_case.debug(message)

	adapter.save()
end

M.delete = function()
	local message = {
		module = "use_cases/layout",
		func = "delete",
	}
	logger_use_case.debug(message)

	adapter.delete()
end

return M
