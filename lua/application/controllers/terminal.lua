local M = {}

local logger_use_case = require("application.use_cases.logger")
local terminal_use_case = require("application.use_cases.terminal")

M.toggle = function(options)
	return function()
		local message = {
			module = "controllers/terminal",
			func = "toggle",
			opts = options,
		}
		logger_use_case.debug(message)
		terminal_use_case.toggle(options)
	end
end

return M
