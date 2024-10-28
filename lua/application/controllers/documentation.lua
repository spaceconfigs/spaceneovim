local M = {}

local logger_use_case = require("application.use_cases.logger")
local documentation_use_case = require("application.use_cases.documentation")

M.open = function()
	return function()
		local message = {
			module = "controllers/documentation",
			func = "open",
		}
		logger_use_case.debug(message)
		documentation_use_case.open()
	end
end

M.install = function()
	return function()
		local message = {
			module = "controllers/documentation",
			func = "install",
		}
		logger_use_case.debug(message)
		documentation_use_case.install()
	end
end

return M
