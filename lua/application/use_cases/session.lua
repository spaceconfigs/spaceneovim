local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.session")

M.list = function()
	local message = {
		module = "use_cases/session",
		func = "list",
	}
	logger_use_case.debug(message)

	adapter.list()
end

M.save = function()
	local message = {
		module = "use_cases/session",
		func = "save",
	}
	logger_use_case.debug(message)

	adapter.save()
end

M.delete = function()
	local message = {
		module = "use_cases/session",
		func = "delete",
	}
	logger_use_case.debug(message)

	adapter.delete()
end

return M
