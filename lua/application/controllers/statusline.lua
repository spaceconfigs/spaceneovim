local M = {}

local logger_use_case = require("application.use_cases.logger")
local statusline_use_case = require("application.use_cases.statusline")

M.toggle = function()
	return function()
		local message = {
			module = "controllers/statusline",
			func = "toggle",
		}
		logger_use_case.debug(message)
		statusline_use_case.toggle()
	end
end

return M
