local M = {}

local logger_use_case = require("application.use_cases.logger")
local diagnostic_use_case = require("application.use_cases.diagnostic")

M.toggle = function()
	return function()
		local message = {
			module = "controllers/diagnostic",
			func = "toggle",
		}
		logger_use_case.debug(message)
		diagnostic_use_case.toggle()
	end
end

M.show = function(direction)
	return function()
		local message = {
			module = "controllers/diagnostic",
			func = "show",
			direction = direction,
		}
		logger_use_case.debug(message)
		diagnostic_use_case.show(direction)
	end
end

M.loclist = function()
	return function()
		local message = {
			module = "controllers/diagnostic",
			func = "loclist",
		}
		logger_use_case.debug(message)
		diagnostic_use_case.loclist()
	end
end

return M
