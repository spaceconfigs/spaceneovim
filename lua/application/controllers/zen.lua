local M = {}

local logger_use_case = require("application.use_cases.logger")
local zen_use_case = require("application.use_cases.zen")

M.toggle = function()
	return function()
		local message = {
			module = "controllers/zen",
			func = "toggle",
		}
		logger_use_case.debug(message)
		zen_use_case.toggle()
	end
end

M.center = function()
	return function()
		local message = {
			module = "controllers/zen",
			func = "center",
		}
		logger_use_case.debug(message)
		zen_use_case.center()
	end
end

M.area = function()
	return function()
		local message = {
			module = "controllers/zen",
			func = "area",
		}
		logger_use_case.debug(message)
		zen_use_case.area()
	end
end

return M
