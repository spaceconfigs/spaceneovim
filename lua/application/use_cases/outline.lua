local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	local message = {
		module = "use_cases/outline",
		func = "setup",
	}
	logger_use_case.debug(message)

	return require("infraestrucuture.adapters.outline")
end

M.toggle = function()
	local message = {
		module = "use_cases/outline",
		func = "toggle",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.toggle()
end

return M
