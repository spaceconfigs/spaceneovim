local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.completer")
end

M.complete = function()
	local message = {
		module = "use_cases/commenter",
		func = "complete",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.complete()
end

return M
