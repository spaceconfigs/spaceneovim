local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.todo")
end

M.list = function()
	local message = {
		module = "use_cases/todo",
		func = "list",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.list()
end

return M
