local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.jumper")

M.timer = function()
	local message = {
		module = "use_cases/jumper",
		func = "words",
	}
	logger_use_case.debug(message)

	adapter.timer()
end

M.words = function()
	local message = {
		module = "use_cases/jumper",
		func = "words",
	}
	logger_use_case.debug(message)

	adapter.words()
end

M.lines = function()
	local message = {
		module = "use_cases/jumper",
		func = "lines",
	}
	logger_use_case.debug(message)

	adapter.lines()
end

return M
