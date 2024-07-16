local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.screenshot")
end

M.copy = function()
	local message = {
		module = "use_cases/screenshot",
		func = "copy",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.copy()
end

M.save = function()
	local message = {
		module = "use_cases/screenshot",
		func = "save",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.save()
end

return M
