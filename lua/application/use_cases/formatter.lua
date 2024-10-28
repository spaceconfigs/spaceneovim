local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.formatter")
end

M.format = function()
	local message = {
		module = "use_cases/formatter",
		func = "format",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.format()
end

return M
