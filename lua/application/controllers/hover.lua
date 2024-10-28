local M = {}

local logger_use_case = require("application.use_cases.logger")
local hover_use_case = require("application.use_cases.hover")

M.toggle = function()
	return function()
		local message = {
			module = "controllers/hover",
			func = "toggle",
		}
		logger_use_case.debug(message)
		hover_use_case.toggle()
	end
end

return M
