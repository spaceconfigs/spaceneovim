local M = {}

local logger_use_case = require("application.use_cases.logger")
local linenumber_use_case = require("application.use_cases.linenumber")

M.toggle_absolute = function()
	return function()
		local message = {
			module = "controllers/linenumber",
			func = "toggle_absolute",
		}
		logger_use_case.debug(message)
		linenumber_use_case.toggle_absolute()
	end
end

M.toggle_relative = function()
	return function()
		local message = {
			module = "controllers/linenumber",
			func = "toggle_relative",
		}
		logger_use_case.debug(message)
		linenumber_use_case.toggle_relative()
	end
end

return M
