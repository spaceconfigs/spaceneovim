local M = {}

local logger_use_case = require("application.use_cases.logger")
local rest_use_case = require("application.use_cases.rest")

M.open = function()
	return function()
		local message = {
			module = "controllers/rest",
			func = "open",
		}
		logger_use_case.debug(message)
		rest_use_case.open()
	end
end

M.send = function()
	return function()
		local message = {
			module = "controllers/rest",
			func = "send",
		}
		logger_use_case.debug(message)
		rest_use_case.send()
	end
end

M.replay = function()
	return function()
		local message = {
			module = "controllers/rest",
			func = "replay",
		}
		logger_use_case.debug(message)
		rest_use_case.replay()
	end
end

return M
