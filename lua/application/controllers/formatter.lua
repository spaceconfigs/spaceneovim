local M = {}

local logger_use_case = require("application.use_cases.logger")
local formatter_use_case = require("application.use_cases.formatter")

M.format = function()
	return function()
		local message = {
			module = "controllers/formatter",
			func = "format",
		}
		logger_use_case.debug(message)
		formatter_use_case.format()
	end
end

return M
