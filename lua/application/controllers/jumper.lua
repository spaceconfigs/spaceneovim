local M = {}

local logger_use_case = require("application.use_cases.logger")
local jumper_use_case = require("application.use_cases.jumper")

M.timer = function(options)
	return function()
		local message = {
			module = "controllers/jumper",
			func = "timer",
			options = options,
		}
		logger_use_case.debug(message)
		jumper_use_case.timer(options)
	end
end

M.words = function()
	return function()
		local message = {
			module = "controllers/jumper",
			func = "words",
		}
		logger_use_case.debug(message)
		jumper_use_case.words()
	end
end

M.lines = function()
	return function()
		local message = {
			module = "controllers/jumper",
			func = "lines",
		}
		logger_use_case.debug(message)
		jumper_use_case.lines()
	end
end

M.remote = function()
	return function()
		local message = {
			module = "controllers/jumper",
			func = "remote",
		}
		logger_use_case.debug(message)
		jumper_use_case.remote()
	end
end

return M
