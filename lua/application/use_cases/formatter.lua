local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.formatter")

M.format = function()
	local message = {
		module = "use_cases/formatter",
		func = "format",
	}
	logger_use_case.debug(message)

	adapter.format()
end

return M
