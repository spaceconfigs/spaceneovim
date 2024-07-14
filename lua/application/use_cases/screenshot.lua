local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.screenshot")

M.copy = function()
	local message = {
		module = "use_cases/screenshot",
		func = "copy",
	}
	logger_use_case.debug(message)

	adapter.copy()
end

M.save = function()
	local message = {
		module = "use_cases/screenshot",
		func = "save",
	}
	logger_use_case.debug(message)

	adapter.save()
end

return M
