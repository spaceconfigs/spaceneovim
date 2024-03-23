local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.bookmarker")

M.add = function()
	local message = {
		module = "use_cases/bookmarker",
		func = "add",
	}
	logger_use_case.debug(message)

	adapter.add()
end

M.remove = function()
	local message = {
		module = "use_cases/bookmarker",
		func = "remove",
	}
	logger_use_case.debug(message)

	adapter.remove()
end

M.remove_all = function()
	local message = {
		module = "use_cases/bookmarker",
		func = "remove_all",
	}
	logger_use_case.debug(message)

	adapter.remove_all()
end

M.list = function()
	local message = {
		module = "use_cases/bookmarker",
		func = "list",
	}
	logger_use_case.debug(message)

	adapter.list()
end

return M
