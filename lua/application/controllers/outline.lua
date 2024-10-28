local M = {}

local logger_use_case = require("application.use_cases.logger")
local outline_use_case = require("application.use_cases.outline")

M.toggle = function()
	return function()
		local message = {
			module = "controllers/outline",
			func = "toggle",
		}
		logger_use_case.debug(message)
		outline_use_case.toggle()
	end
end

return M
