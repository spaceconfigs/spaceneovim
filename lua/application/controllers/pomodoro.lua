local M = {}

local logger_use_case = require("application.use_cases.logger")
local pomodoro_use_case = require("application.use_cases.pomodoro")

M.start = function()
	return function()
		local message = {
			module = "controllers/pomodoro",
			func = "start",
		}
		logger_use_case.debug(message)
		pomodoro_use_case.start()
	end
end

M.status = function()
	return function()
		local message = {
			module = "controllers/pomodoro",
			func = "status",
		}
		logger_use_case.debug(message)
		pomodoro_use_case.status()
	end
end

return M
