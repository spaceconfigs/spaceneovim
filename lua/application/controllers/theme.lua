local M = {}

local logger_use_case = require("application.use_cases.logger")
local theme_use_case = require("application.use_cases.theme")

M.list = function()
	return function()
		local message = {
			module = "controllers/theme",
			func = "list",
		}
		logger_use_case.debug(message)
		theme_use_case.list()
	end
end

M.load = function()
	return function()
		local message = {
			module = "controllers/theme",
			func = "load",
		}
		logger_use_case.debug(message)
		theme_use_case.load()
	end
end

return M
