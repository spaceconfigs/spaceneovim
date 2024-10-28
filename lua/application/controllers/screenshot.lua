local M = {}

local logger_use_case = require("application.use_cases.logger")
local screenshot_use_case = require("application.use_cases.screenshot")

M.copy = function(options)
	return function()
		local message = {
			module = "controllers/screenshot",
			func = "copy",
			options = options,
		}
		logger_use_case.debug(message)
		screenshot_use_case.copy(options)
	end
end

M.save = function(options)
	return function()
		local message = {
			module = "controllers/screenshot",
			func = "save",
			options = options,
		}
		logger_use_case.debug(message)
		screenshot_use_case.save(options)
	end
end

return M
