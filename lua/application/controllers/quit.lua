local M = {}

local logger_use_case = require("application.use_cases.logger")
local quit_use_case = require("application.use_cases.quit")

M.all = function()
	return function()
		local message = {
			module = "controllers/quit",
			func = "all",
		}
		logger_use_case.debug(message)
		quit_use_case.all()
	end
end

M.save_all = function()
	return function()
		local message = {
			module = "controllers/quit",
			func = "save_all",
		}
		logger_use_case.debug(message)
		quit_use_case.save_all()
	end
end

return M
